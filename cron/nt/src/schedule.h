/* _/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
	schedule.h
		�X�P�W���[���p�֐���`
 _/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/ */
#if !defined(__schedule__h)
#define __schedule__h



// ___�yinclude�z__________________________________________________
#include <time.h>
#include <string>
#include <fstream>
#include <vector>
#include "CTask.h"
using namespace std;



// ___ �ydefine�z__________________________________________________
#define CRONTAB_INI_FILE	"crontab.ini"	// INI�t�@�C����
#define LOG_FILE			"crontab.log"	// ���O�t�@�C����
#define TASK_MAX			30				// �ő�^�X�N��

#define ROW_SIZE			2046			// INI�t�@�C�����̈�s�̍ő啶����
#define LOG_SIZE			2046			// LOG�t�@�C�����̈�s�̍ő啶����
#define BUF_SIZE			256				// �w��ł���͈͂̍ő啶����




// ___ �yfunction�z__________________________________________________
extern BOOL LoadSchedule();
extern void CreateScheduleThread();
extern void StopScheduleThread();
extern void SuspendScheduleThread();
extern void ResumeScheduleThread();
extern void ObserverThread( void );
extern BOOL DoSystemCommand( const char * );
extern void WriteLog( const char * );
extern void WriteErrLog( const char *, DWORD dwErrorNumber = GetLastError() );
extern void MsgBox( const char * , const char *  );
extern void GetAppPath( string *path );
extern void trim( char *src );


#endif
