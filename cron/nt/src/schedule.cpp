/* _/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
	schedule.cpp
		�X�P�W���[���p�֐�
 _/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/ */

// ___�yinclude�z__________________________________________________
#include "stdafx.h"
#include "schedule.h"


//___ �ystatic validate�z__________________________________________________
vector <CTask> schedule;				// �X�P�W���[���z��
volatile BOOL thread_flg;				// �X���b�h�I���p�t���O
static HANDLE hThread = NULL ;			// �Ď��p�X���b�h�n���h��
static DWORD threadID ;					// �Ď��p�X���b�h�h�c
static string apppath = _T("");			// �A�v���P�[�V�����p�X



//___ �yextern function�z__________________________________________________
/* ====================================
	�X�P�W���[���Ǎ�
==================================== */
BOOL LoadSchedule(){

	//++ �A�v���P�[�V�����p�X�̎擾
	GetAppPath( &apppath );

	//++ �t�@�C�����̎擾
	char fname[_MAX_PATH];
	memset( fname, '\0', _MAX_PATH );
	strcpy( fname, (LPTSTR)apppath.c_str() );
	strcat( fname, CRONTAB_INI_FILE );

	//++ �t�@�C���I�[�v�� ++
	WriteLog( "������ Start ����������������������������������������������������������������������������������" );
	WriteLog( "�X�P�W���[���t�@�C���Ǎ��J�n" );
    ifstream file;
	file.open( fname );
	if( !file.is_open() ){
		MsgBox( "�X�P�W���[���t�@�C�����J���܂���B", "crontab" );
		WriteLog( "��Error!���X�P�W���[���t�@�C�����J���܂���B" );
		return false;
	}

	//++ �ǂݍ��� ++
    char buf[ROW_SIZE];
	int count = 0, row = 0;
	while( count < TASK_MAX ) {
		memset( buf, '\0', ROW_SIZE );
		file.getline( buf, ROW_SIZE );
		trim( buf );
		row++;
		if( strlen( buf ) != 0 && *buf!='#' ){

			CTask *lptask = new CTask;
			if( !(lptask->SetFormatData( buf )) ){
				char logbuf[BUF_SIZE];
				memset( logbuf, '\0', BUF_SIZE );
				sprintf( logbuf, "line %d: -> %s\n�X�P�W���[����`���s���ł�", row, buf );
				MsgBox( logbuf, "crontab" );
				WriteLog( logbuf );
				file.close();
				delete lptask;
				return false;
			}
			schedule.push_back( *lptask );
			delete lptask;
			count++;
		}
		if( file.eof() ) break;
    }
	if( count<=0 ){
		MsgBox( "�X�P�W���[������`����Ă��܂���B", "crontab" );
		WriteLog( "�X�P�W���[������`����Ă��܂���B" );
		file.close();
		return false;
	}

    /* �t�@�C���N���[�Y */
	file.close();

	WriteLog( "�X�P�W���[���t�@�C���Ǎ�����" );
	return true;
}



/* ====================================
	�Ď��p�X���b�h����
==================================== */
void CreateScheduleThread(){
	/* �Ď��p���[�v�X���b�h�̍쐬 */
	if( hThread == NULL ){
		hThread = CreateThread( 0, 0, 
					(LPTHREAD_START_ROUTINE)ObserverThread,
									0, 0, &threadID );
		if( hThread == (HANDLE)NULL ){
			//++ �X���b�h�쐬���s��
			DWORD dwErrorNumber = GetLastError();
			WriteErrLog( "�Ď��X���b�h���J�n�ł��܂���ł����B" );
			ExitThread( dwErrorNumber );
			//CloseHandle( hThread );
			hThread = NULL;
		}else{
			WriteLog( "�Ď��X���b�h���J�n���܂����B" );
		}
	}

}



/* ====================================
	�Ď��p�X���b�h��~
==================================== */
void StopScheduleThread(){
	/* �Ď��X���b�h��~ */
	thread_flg = false;
	if( hThread ) {
		while( WaitForSingleObject( hThread, 0 ) == WAIT_TIMEOUT ){
			if( hThread )
			    CloseHandle( hThread );
			hThread = NULL;
		}
		WriteLog( "�Ď��X���b�h���~���܂����B" );
	}
}



/* ====================================
	�Ď��p�X���b�h�ꎞ��~
==================================== */
void SuspendScheduleThread(){
	/* �Ď��X���b�h�ꎞ��~ */
	if( hThread ){
		SuspendThread( hThread );
		WriteLog( "�Ď��X���b�h���ꎞ��~���܂����B" );
	}
}



/* ====================================
	�Ď��p�X���b�h�ĊJ
==================================== */
void ResumeScheduleThread(){
	/* �Ď��X���b�h�ĊJ */
	if( hThread ){
		ResumeThread( hThread );
		WriteLog( "�Ď��X���b�h���ĊJ���܂����B" );
	}
}



/* ====================================
	�Ď��p���W���[��
==================================== */
void ObserverThread()
{
	vector <CTask>::iterator p;		// �X�P�W���[���z��ւ̃C�e���[�^�[

	// �T�[�r�X��~���ɁAvolatile �t���O�� False �ɂȂ�܂Ń��[�v������
	thread_flg = true;
	while( thread_flg ){
		time_t now = time(NULL);
		struct tm *pnow = localtime(&now);
		pnow->tm_sec = 0;
		now = mktime( pnow );
		int cnt = 0;
		for( p = schedule.begin(); p != schedule.end(); p++ ){
			cnt++;
			if( p->m_time != now ){
				if( ( p->minute.find( pnow->tm_min )!=p->minute.end() ) && 
					( p->hour.find( pnow->tm_hour )!=p->hour.end() ) && 
					( p->dom.find( pnow->tm_mday )!=p->dom.end() ) && 
					( p->month.find( pnow->tm_mon + 1 )!=p->month.end() ) && 
					( p->dow.find( pnow->tm_wday )!=p->dow.end() ) )
				{
					char buf[LOG_SIZE];
					memset( buf, '\0', LOG_SIZE );
					sprintf( buf, "�X�P�W���[�� %d �����s���Ă��܂��B�B", cnt );
					WriteLog( buf );
					if( DoSystemCommand( (char*)p->m_cmd.c_str() ) ){
						p->m_time = now;
					}
				}
			}
		}
		now = time(NULL);
		Sleep( ( 60 - ( localtime(&now)->tm_sec ) ) * 1000 );
	}
	WriteLog( "�X���b�h���J�����܂����B" );
	ExitThread( 0 );
}



/* ====================================
	�V�����v���Z�X���N��������֐�
==================================== */
BOOL DoSystemCommand( const char *cmd )
{

	// STARTUPINFOR �\���̎擾
	STARTUPINFO startUpInfo;
	PROCESS_INFORMATION procInfo;
	GetStartupInfo( &startUpInfo ) ;
        
	// �v���Z�X���쐬
	BOOL retval;
	char logbuf[LOG_SIZE];
	if( retval = CreateProcess( 0, (char*)cmd, 0, 0, FALSE, CREATE_NEW_CONSOLE, 
		0, 0, &startUpInfo, &procInfo ) ){

		//++ �R�}���h���s������
		memset( logbuf, '\0', LOG_SIZE );
		sprintf( logbuf, "ooooooo �R�}���h�����s���܂����B[>> %s ]", cmd );
		WriteLog( logbuf );

		// �n���h�������
		CloseHandle( procInfo.hThread );
		CloseHandle( procInfo.hProcess );

	}else{

		//++ �R�}���h���s���s��
		memset( logbuf, '\0', LOG_SIZE );
		sprintf( logbuf, "�R�}���h�̎��s�Ɏ��s���܂����B[>> %s ]", cmd );
		WriteErrLog( logbuf );

	};
	return retval;
}



/* ====================================
	���O�o�͊֐�
==================================== */
void WriteLog( const char *buf ){

	//++ �t�@�C�����̎擾
	char fname[_MAX_PATH];
	memset( fname, '\0', _MAX_PATH );
	strcpy( fname, (LPTSTR)apppath.c_str() );
	strcat( fname, LOG_FILE );

	//++ �^�C���X�^���v�̎擾
	char tm_stamp[64];
	time_t now = time(NULL);
	struct tm *pnow = localtime( &now );
	memset( tm_stamp, '\0', 64 );
	strftime( tm_stamp, 64, "%m/%d %H:%M:%S  >", pnow );

	//++ ���O�o��
    ofstream file;
	file.open( fname, ios::out | ios::app );
	if( !file.is_open() ) return;
	file << tm_stamp << buf << endl;
	file.close();
	
}


/* ====================================
	�G���[���O�o�͊֐�
==================================== */
void WriteErrLog( const char *buf, DWORD dwErrorNumber ){
	char logbuf[LOG_SIZE];
	LPVOID lpMsgBuf;
	FormatMessage( FORMAT_MESSAGE_ALLOCATE_BUFFER | FORMAT_MESSAGE_FROM_SYSTEM | FORMAT_MESSAGE_IGNORE_INSERTS,
			NULL, dwErrorNumber, MAKELANGID(LANG_NEUTRAL, SUBLANG_DEFAULT), (LPTSTR) &lpMsgBuf, 0, NULL );

	memset( logbuf, '\0', LOG_SIZE );
	sprintf( logbuf, "��Error!�� %s \nError Number:%d\nError String:%s\n", buf, dwErrorNumber, lpMsgBuf );
	WriteLog( logbuf );
}



/* ====================================
	���b�Z�[�W�{�b�N�X�֐�
==================================== */
void MsgBox( const char* Text, const char* Caption )
{
	MessageBox( NULL, Text, Caption, MB_OK | MB_ICONEXCLAMATION | MB_SERVICE_NOTIFICATION );
}


/* ====================================
	�A�v���P�[�V�����p�X�̎擾
==================================== */
void GetAppPath( string *path )
{
	char module[_MAX_PATH];
	char drive[_MAX_DRIVE];
	char dir[_MAX_DIR];
	char fname[_MAX_FNAME];
	char ext[_MAX_EXT];

	// ���W���[���t�@�C�����̎擾
	memset( module, '\0', _MAX_PATH );
	GetModuleFileName( NULL, module, _MAX_PATH );

	// �t�@�C�����̕���
	memset( drive, '\0', _MAX_DRIVE );
	memset( dir, '\0', _MAX_DIR );
	memset( fname, '\0', _MAX_FNAME );
	memset( ext, '\0', _MAX_EXT );
	_splitpath( module, drive, dir, fname, ext );

	// �p�X��Ԃ�
	path->assign( drive );
	path->append( dir );
}


/* ====================================
	��������g��������
==================================== */
void trim( char *src )
{
	char *pl,*ps;

	// RTrim
	pl = src + strlen( src ) - 1;
	while( pl >= src && ( ( *pl>=0x09 && *pl<=0x0d ) || ( *pl==0x20 ) ) )
		*pl-- = '\0';

	// LTrim
	ps = src;
	while( ps <= pl && ( ( *ps>=0x09 && *ps<=0x0d ) || ( *ps==0x20 ) ) )
		*ps++;
	strcpy( src, ps );

}

