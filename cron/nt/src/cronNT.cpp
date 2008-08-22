// cronNT.cpp : WinMain �̃C���v�������e�[�V����


// ����: Proxy/Stub ���
//  �ʁX�� proxy/stub DLL ���r���h���邽�߂ɂ́A�v���W�F�N�g�̃f�B���N�g���� 
//      nmake -f cronNTps.mak �����s���Ă��������B

#include "stdafx.h"
#include "resource.h"
#include <initguid.h>
#include "cronNT.h"

#include "cronNT_i.c"

#include "schedule.h"

#include <stdio.h>

CServiceModule _Module;

BEGIN_OBJECT_MAP(ObjectMap)
END_OBJECT_MAP()


LPCTSTR FindOneOf(LPCTSTR p1, LPCTSTR p2)
{
    while (p1 != NULL && *p1 != NULL)
    {
        LPCTSTR p = p2;
        while (p != NULL && *p != NULL)
        {
            if (*p1 == *p)
                return CharNext(p1);
            p = CharNext(p);
        }
        p1 = CharNext(p1);
    }
    return NULL;
}

// �����̊֐��̂������͑傫���ł����A1 �x�����g�p����Ȃ����߃C�����C���Ő錾����܂��B

inline HRESULT CServiceModule::RegisterServer(BOOL bRegTypeLib, BOOL bService)
{
    HRESULT hr = CoInitialize(NULL);
    if (FAILED(hr))
        return hr;

    // �Ԉ�����t�@�C�����w�肷��\�������邽�߁A�ȑO�̃T�[�r�X��
    // ���ׂč폜���܂�
    Uninstall();

    // �T�[�r�X �G���g����ǉ����܂�
    UpdateRegistryFromResource(IDR_CronNT, TRUE);

    // AppID �����[�J�� �T�[�o�[�܂��̓T�[�r�X�p�ɒ������܂�
    CRegKey keyAppID;
    LONG lRes = keyAppID.Open(HKEY_CLASSES_ROOT, _T("AppID"), KEY_WRITE);
    if (lRes != ERROR_SUCCESS)
        return lRes;

    CRegKey key;
    lRes = key.Open(keyAppID, _T("{16001B22-F5E8-11D5-A455-525405E32B2D}"), KEY_WRITE);
    if (lRes != ERROR_SUCCESS)
        return lRes;
    key.DeleteValue(_T("LocalService"));
    
    if (bService)
    {
        key.SetValue(_T("cronNT"), _T("LocalService"));
        key.SetValue(_T("-Service"), _T("ServiceParameters"));
        // �T�[�r�X���쐬���܂�
        Install();
    }

    // �I�u�W�F�N�g �G���g����ǉ����܂�
    hr = CComModule::RegisterServer(bRegTypeLib);

    CoUninitialize();
    return hr;
}

inline HRESULT CServiceModule::UnregisterServer()
{
    HRESULT hr = CoInitialize(NULL);
    if (FAILED(hr))
        return hr;

    // �T�[�r�X �G���g�����폜���܂�
    UpdateRegistryFromResource(IDR_CronNT, FALSE);
    // �T�[�r�X���폜���܂�
    Uninstall();
    // �I�u�W�F�N�g �G���g�����폜���܂�
    CComModule::UnregisterServer(TRUE);
    CoUninitialize();
    return S_OK;
}

inline void CServiceModule::Init(_ATL_OBJMAP_ENTRY* p, HINSTANCE h, UINT nServiceNameID, const GUID* plibid)
{
    CComModule::Init(p, h, plibid);

    m_bService = TRUE;

    LoadString(h, nServiceNameID, m_szServiceName, sizeof(m_szServiceName) / sizeof(TCHAR));

    // �T�[�r�X�̏�����Ԃ�ݒ肵�܂� 
    m_hServiceStatus = NULL;
    m_status.dwServiceType = SERVICE_WIN32_OWN_PROCESS;
    m_status.dwCurrentState = SERVICE_STOPPED;
    m_status.dwControlsAccepted = SERVICE_ACCEPT_STOP;
    m_status.dwWin32ExitCode = 0;
    m_status.dwServiceSpecificExitCode = 0;
    m_status.dwCheckPoint = 0;
    m_status.dwWaitHint = 0;
}

LONG CServiceModule::Unlock()
{
    LONG l = CComModule::Unlock();
    if (l == 0 && !m_bService)
        PostThreadMessage(dwThreadID, WM_QUIT, 0, 0);
    return l;
}

BOOL CServiceModule::IsInstalled()
{
    BOOL bResult = FALSE;

    SC_HANDLE hSCM = ::OpenSCManager(NULL, NULL, SC_MANAGER_ALL_ACCESS);

    if (hSCM != NULL)
    {
        SC_HANDLE hService = ::OpenService(hSCM, m_szServiceName, SERVICE_QUERY_CONFIG);
        if (hService != NULL)
        {
            bResult = TRUE;
            ::CloseServiceHandle(hService);
        }
        ::CloseServiceHandle(hSCM);
    }
    return bResult;
}

inline BOOL CServiceModule::Install()
{
    if (IsInstalled())
        return TRUE;

    SC_HANDLE hSCM = ::OpenSCManager(NULL, NULL, SC_MANAGER_ALL_ACCESS);
    if (hSCM == NULL)
    {
        MessageBox(NULL, _T("�T�[�r�X �}�l�[�W���[���J���܂���ł���"), m_szServiceName, MB_OK);
        return FALSE;
    }

    // ���s�t�@�C���̃p�X���擾���܂�
    TCHAR szFilePath[_MAX_PATH];
    ::GetModuleFileName(NULL, szFilePath, _MAX_PATH);

    SC_HANDLE hService = ::CreateService(
        hSCM, m_szServiceName, m_szServiceName,
        SERVICE_ALL_ACCESS, SERVICE_WIN32_OWN_PROCESS,
        SERVICE_DEMAND_START, SERVICE_ERROR_NORMAL,
        szFilePath, NULL, NULL, _T("RPCSS\0"), NULL, NULL);

    if (hService == NULL)
    {
        ::CloseServiceHandle(hSCM);
        MessageBox(NULL, _T("�T�[�r�X���쐬�ł��܂���ł���"), m_szServiceName, MB_OK);
        return FALSE;
    }

    ::CloseServiceHandle(hService);
    ::CloseServiceHandle(hSCM);
    return TRUE;
}

inline BOOL CServiceModule::Uninstall()
{
    if (!IsInstalled())
        return TRUE;

    SC_HANDLE hSCM = ::OpenSCManager(NULL, NULL, SC_MANAGER_ALL_ACCESS);

    if (hSCM == NULL)
    {
        MessageBox(NULL, _T("�T�[�r�X �}�l�[�W���[���J���܂���ł���"), m_szServiceName, MB_OK);
        return FALSE;
    }

    SC_HANDLE hService = ::OpenService(hSCM, m_szServiceName, SERVICE_STOP | DELETE);

    if (hService == NULL)
    {
        ::CloseServiceHandle(hSCM);
        MessageBox(NULL, _T("�T�[�r�X���J���܂���ł���"), m_szServiceName, MB_OK);
        return FALSE;
    }
    SERVICE_STATUS status;
    ::ControlService(hService, SERVICE_CONTROL_STOP, &status);

    BOOL bDelete = ::DeleteService(hService);
    ::CloseServiceHandle(hService);
    ::CloseServiceHandle(hSCM);

    if (bDelete)
        return TRUE;

    MessageBox(NULL, _T("�T�[�r�X�͍폜�ł��܂���ł���"), m_szServiceName, MB_OK);
    return FALSE;
}

///////////////////////////////////////////////////////////////////////////////////////
// ���O�֐�
void CServiceModule::LogEvent(LPCTSTR pFormat, ...)
{
    TCHAR    chMsg[256];
    HANDLE  hEventSource;
    LPTSTR  lpszStrings[1];
    va_list pArg;

    va_start(pArg, pFormat);
    _vstprintf(chMsg, pFormat, pArg);
    va_end(pArg);

    lpszStrings[0] = chMsg;

    if (m_bService)
    {
        /* ReportEvent() �Ŏg�p����n���h�����擾���܂��B */
        hEventSource = RegisterEventSource(NULL, m_szServiceName);
        if (hEventSource != NULL)
        {
            /* �C�x���g ���O�֏������݂܂��B */
            ReportEvent(hEventSource, EVENTLOG_INFORMATION_TYPE, 0, 0, NULL, 1, 0, (LPCTSTR*) &lpszStrings[0], NULL);
            DeregisterEventSource(hEventSource);
        }
    }
    else
    {
        // �T�[�r�X�̎��s���ł͂Ȃ��̂ŁA�G���[���R���\�[���ɏ������ނ����ł��B
        _putts(chMsg);
    }
}

//////////////////////////////////////////////////////////////////////////////////////////////
// �T�[�r�X�̃X�^�[�g�A�b�v����ѓo�^
inline void CServiceModule::Start()
{
    SERVICE_TABLE_ENTRY st[] =
    {
        { m_szServiceName, _ServiceMain },
        { NULL, NULL }
    };
    if (m_bService && !::StartServiceCtrlDispatcher(st))
    {
        m_bService = FALSE;
    }
    if (m_bService == FALSE)
        Run();
}

inline void CServiceModule::ServiceMain(DWORD /* dwArgc */, LPTSTR* /* lpszArgv */)
{
    // �R���g���[���v���n���h����o�^���܂�
    m_status.dwCurrentState = SERVICE_START_PENDING;
    m_hServiceStatus = RegisterServiceCtrlHandler(m_szServiceName, _Handler);
    if (m_hServiceStatus == NULL)
    {
        LogEvent(_T("Handler not installed"));
        return;
    }
    SetServiceStatus(SERVICE_START_PENDING);

    m_status.dwWin32ExitCode = S_OK;
    m_status.dwCheckPoint = 0;
    m_status.dwWaitHint = 0;

    // ���s�֐����Ԃ鎞�A�T�[�r�X�͒�~���܂��B
    Run();

    SetServiceStatus(SERVICE_STOPPED);
    LogEvent(_T("Service stopped"));
}

inline void CServiceModule::Handler(DWORD dwOpcode)
{
    switch (dwOpcode)
    {
    case SERVICE_CONTROL_STOP:
		// �Ď��X���b�h�̒�~
		StopScheduleThread();

        SetServiceStatus(SERVICE_STOP_PENDING);
        PostThreadMessage(dwThreadID, WM_QUIT, 0, 0);
        break;

    case SERVICE_CONTROL_PAUSE:
		// �Ď��X���b�h�̈ꎞ��~
		SuspendScheduleThread();

        break;

    case SERVICE_CONTROL_CONTINUE:
		// �Ď��X���b�h�̍ĊJ
		ResumeScheduleThread();
        break;

    case SERVICE_CONTROL_INTERROGATE:
		// �Ď��X���b�h�̒�~
		// StopScheduleThread();
        break;

    case SERVICE_CONTROL_SHUTDOWN:
		// �Ď��X���b�h�̒�~
		StopScheduleThread();
        break;

    default:
        LogEvent(_T("Bad service request"));
    }
}

void WINAPI CServiceModule::_ServiceMain(DWORD dwArgc, LPTSTR* lpszArgv)
{
    _Module.ServiceMain(dwArgc, lpszArgv);
}
void WINAPI CServiceModule::_Handler(DWORD dwOpcode)
{
    _Module.Handler(dwOpcode); 
}

void CServiceModule::SetServiceStatus(DWORD dwState)
{
    m_status.dwCurrentState = dwState;
    ::SetServiceStatus(m_hServiceStatus, &m_status);
}

void CServiceModule::Run()
{
    _Module.dwThreadID = GetCurrentThreadId();

    HRESULT hr = CoInitialize(NULL);
// NT 4.0 �ȏ���g�p���Ă���ꍇ�́A�X���b�h �t���[�� EXE ��
// �쐬���邩���Ɉȉ��̌Ăяo�����g�p�ł��܂��B
// ����͌Ăяo���������_���� RPC �X���b�h��œ��邱�Ƃ��Ӗ����܂��B
// HRESULT hr = CoInitializeEx(NULL, COINIT_MULTITHREADED);

    _ASSERTE(SUCCEEDED(hr));

    // �S���ɃA�N�Z�X�������� NULL DACL ��񋟂��܂��B
    CSecurityDescriptor sd;
    sd.InitializeFromThreadToken();
    hr = CoInitializeSecurity(sd, -1, NULL, NULL,
        RPC_C_AUTHN_LEVEL_PKT, RPC_C_IMP_LEVEL_IMPERSONATE, NULL, EOAC_NONE, NULL);
    _ASSERTE(SUCCEEDED(hr));

    hr = _Module.RegisterClassObjects(CLSCTX_LOCAL_SERVER | CLSCTX_REMOTE_SERVER, REGCLS_MULTIPLEUSE);
    _ASSERTE(SUCCEEDED(hr));

    LogEvent(_T("Service started"));
	if (m_bService)
        SetServiceStatus(SERVICE_RUNNING);

	// ---------------------------------------------------
	// �X�P�W���[���̍쐬
	if( LoadSchedule() ){
		// �Ď��X���b�h�̍쐬
		CreateScheduleThread();
	}
	// ---------------------------------------------------

    MSG msg;
    while (GetMessage(&msg, 0, 0, 0))
        DispatchMessage(&msg);

    _Module.RevokeClassObjects();

    CoUninitialize();
}

/////////////////////////////////////////////////////////////////////////////
//
extern "C" int WINAPI _tWinMain(HINSTANCE hInstance, 
    HINSTANCE /*hPrevInstance*/, LPTSTR lpCmdLine, int /*nShowCmd*/)
{
    lpCmdLine = GetCommandLine(); // ���̍s�� _ATL_MIN_CRT �ɑ΂��ĕK�v�ł�
    _Module.Init(ObjectMap, hInstance, IDS_SERVICENAME, &LIBID_CRONNTLib);
    _Module.m_bService = TRUE;

    TCHAR szTokens[] = _T("-/");

    LPCTSTR lpszToken = FindOneOf(lpCmdLine, szTokens);
    while (lpszToken != NULL)
    {
        if (lstrcmpi(lpszToken, _T("UnregServer"))==0)
            return _Module.UnregisterServer();

        // ���[�J�� �T�[�o�[�Ƃ��ēo�^���܂�
        if (lstrcmpi(lpszToken, _T("RegServer"))==0)
            return _Module.RegisterServer(TRUE, FALSE);
        
        // �T�[�r�X�Ƃ��ēo�^���܂�
        if (lstrcmpi(lpszToken, _T("Service"))==0)
            return _Module.RegisterServer(TRUE, TRUE);
        
        lpszToken = FindOneOf(lpszToken, szTokens);
    }

    // �T�[�r�X�܂��̓��[�J�� �T�[�o�[���ǂ������肵�܂�
    CRegKey keyAppID;
    LONG lRes = keyAppID.Open(HKEY_CLASSES_ROOT, _T("AppID"), KEY_READ);
    if (lRes != ERROR_SUCCESS)
        return lRes;

    CRegKey key;
    lRes = key.Open(keyAppID, _T("{16001B22-F5E8-11D5-A455-525405E32B2D}"), KEY_READ);
    if (lRes != ERROR_SUCCESS)
        return lRes;

    TCHAR szValue[_MAX_PATH];
    DWORD dwLen = _MAX_PATH;
    lRes = key.QueryValue(szValue, _T("LocalService"), &dwLen);

    _Module.m_bService = FALSE;
    if (lRes == ERROR_SUCCESS)
        _Module.m_bService = TRUE;

    _Module.Start();

    // ���̈ʒu�ɗ����Ƃ��̓T�[�r�X�͒�~����Ă��܂�
    return _Module.m_status.dwWin32ExitCode;
}

