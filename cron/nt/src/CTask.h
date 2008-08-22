/* _/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
	CTask.h
		�^�X�N�p�N���X��`
 _/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/ */
#if !defined(__ctask__h)
#define __ctask__h



// ___�yinclude�z__________________________________________________
#include "stdafx.h"
#include <time.h>
#include <string>
#include <set>
using namespace std;


// ___ �yCTask class�z__________________________________________________
/*
	�X�P�W���[�����i�[����A�N���X�ł��B
	���̃N���X�� vector �z����Astatic �ɕێ����܂��B
*/
class CTask
{
public:
	set<unsigned int> minute;		// ��
	set<unsigned int> hour;			// ��
	set<unsigned int> dom;			// ��
	set<unsigned int> month;		// ��
	set<unsigned int> dow;			// �j��
	string m_cmd;					// ���s�R�}���h

	time_t m_time;					// ���s�ς݃`�F�b�N�p

public:

	/* -----------------------------------------------------------
		CTask �R���X�g���N�^
	----------------------------------------------------------- */
	CTask() {
		m_cmd	= _T("");
		m_time	= NULL;
	}
	

	/* -----------------------------------------------------------
		INI�t�@�C���̏�������A�e�v���p�e�B���Z�b�g�����郁�\�b�h

		[����]min hor dom mon dow cmd
		min: ��
		hor: ����
		dom: ��
		mon: ��
		dow: �j��
		cmd: ���s����R�}���h�i�󔒂������Ă��悢�j

		(��)
		*:			���`
		1:			�P�̎w��
		1,2,3:		�����w��
		1-10:		�͈͎w��
		5,10-15,23	�d���w��									*/
	//	*/5:		�Ԋu�w��i�������A0����N�Z����j
	/*
		(���L)
		�E�����w��A�܂��͏d���w�莞�ɁA�������l������ꍇ�́A
		�@�G���[�ɂ͂Ȃ炸�ɁA�d�������ɃX�P�W���[���o�^����܂��B
		�E�w�肵���͈͈ȉ��A�ȏ�̒l��ݒ肷��ƁA�G���[�ɂȂ�܂��B
	----------------------------------------------------------- */
	BOOL SetFormatData( const char *buf){

		// ���������ꂽ�A��s����A�e�f�[�^�l���擾
		unsigned char mi[256], hr[256], dt[256], mt[256], wk[256], cm[2046];
		memset( mi,	0, 256 );
		memset( hr,	0, 256 );
		memset( dt,	0, 256 );
		memset( mt,	0, 256 );
		memset( wk,	0, 256 );
		memset( cm,	0, 2046 );
		if( sscanf( buf, "%s %s %s %s %s %[^\0]", mi, hr, dt, mt, wk, cm ) != 6 )
			return false;

		// �擾�f�[�^�́A�s���`�F�b�N�ƃZ�b�g
		if( get_data( (char*)mi, &minute,	0, 59 )<=0 ) return false;
		if( get_data( (char*)hr, &hour,		0, 24 )<=0 ) return false;
		if( get_data( (char*)dt, &dom,		1, 31 )<=0 ) return false;
		if( get_data( (char*)mt, &month,	1, 12 )<=0 ) return false;
		if( get_data( (char*)wk, &dow,		0,  6 )<=0 ) return false;
		m_cmd.append( (char*)cm );
		m_time = NULL;

		return true;
	}


	/* -----------------------------------------------------------
		�f�[�^�`�F�b�N�^�Z�b�g�֐�
	----------------------------------------------------------- */
	unsigned int get_data( const char *src, set<unsigned int> *lst, unsigned int min, unsigned int max ){

		unsigned int cnt;		// �Z�b�g�������i�Ԃ�l�j
		unsigned int val;		// �Z�b�g����l�̔ėp�ϐ�
		if( *src=='*' ){
			unsigned int step = 1;
			if( *(src+1)=='/' ){
				if( ( sscanf( src, "*/%u", &step )!=1 ) || ( step<=0 ) ) return 0;
			}
			cnt = 0;
			for( val=min; val<=max; val+=step ){
				lst->insert( val );
				cnt++;
			}
		}else{
			char *p = NULL;
			unsigned int st, ls;
			cnt = 0;
			p = strtok( (char*)src, "," );
			while( p != NULL ){
				if( sscanf( p, "%d-%d", &st, &ls )==2 ){
					if( ls<min || ls>max || st<min || st>max || ls<=st ) return 0;
					for( val=st; val<=ls; val++ ){
						if( lst->find(val)==lst->end() ){
							lst->insert( val );
							cnt++;
						}
					}
				}else{
					val = cnv_to_ui( p );
					if( lst->find(val)==lst->end() ){
						lst->insert( val );
						cnt++;
					}
				}
				p = strtok( NULL, "," );
			}
		}
		return cnt;
	}


	/* -----------------------------------------------------------
		�����񁨐��l�ϊ��֐�
	----------------------------------------------------------- */
	unsigned int cnv_to_ui( const char *str ){
		unsigned int i, val = 0;
		for( i=0; i<strlen(str); i++ ){
			if( str[i] >= 0x30 && str[i] <= 0x39 ){
				val *= 10;
				val += ( str[i] - 0x30 );
			}
		}
		return val;
	}


};


#endif
