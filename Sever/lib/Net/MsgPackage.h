#pragma once
#include <windows.h>
#include <vector>
#include "msgdata.h"
#include <limits.h>
#include "Util.h"

//using namespace std;
namespace SevenSmile{
	namespace Net{
		extern "C" class MsgPackage
		{
		public:
			__declspec(dllexport) MsgPackage(void);
			__declspec(dllexport) ~MsgPackage(void);
			//__declspec(dllexport) MsgPackage(const MsgPackage &packet)
			//	:_usPackageTotalLength(packet._usPackageTotalLength),_usPackageAction(packet._usPackageAction),_vMsgData=packet.
			//{
			//}

			/************************************************************************/
			/* 解包                                                                 */
			/************************************************************************/
			__declspec(dllexport)  bool UnPackage(char* i_lpChar,USHORT i_usLength);

			__declspec(dllexport) USHORT GetPackageTotalLength(void);
			__declspec(dllexport) USHORT GetPackageAction(void);
			__declspec(dllexport) UINT GetMsgDatasNum(void);
			__declspec(dllexport) MsgData* GetMsgDataById(UINT i);
			__declspec(dllexport) MsgData* GetMsgDataByAction(USHORT i_usAction);
			__declspec(dllexport) std::vector<MsgData*> GetMsgDatas(void);
			//__declspec(dllexport) char*& ToStringUnPackage();

			/************************************************************************/
			/*打包																	*/
			/************************************************************************/
			__declspec(dllexport) void SetPackageAction(USHORT i_usHeadAction);

			__declspec(dllexport) void AddMsgData(USHORT i_usAction,int i_intData);
			__declspec(dllexport) void AddMsgData(USHORT i_usAction,UINT i_intData);
			__declspec(dllexport) void AddMsgDataIntU(USHORT i_usAction,UINT i_uintData);
			__declspec(dllexport) void AddMsgDataInt(USHORT i_usAction,int i_intData);
			__declspec(dllexport) void AddMsgDataShortU(USHORT i_usAction,USHORT i_ushortData);
			__declspec(dllexport) void AddMsgDataShort(USHORT i_usAction,short i_shortData);
			__declspec(dllexport) void AddMsgDataCharU(USHORT i_usAction,UCHAR i_ubyteData);
			__declspec(dllexport) void AddMsgDataChar(USHORT i_usAction,char i_byteData);

			__declspec(dllexport) void AddMsgData(USHORT i_usAction,char* i_lpCharContent,USHORT i_usContentLength);
			__declspec(dllexport) void AddMsgData(USHORT i_usAction);

			//__declspec(dllexport) int Package(char **msg);
			__declspec(dllexport) int Package(char* &msg);

			__declspec(dllexport) const char* ToStringPackage();
			

		private:
			void Init(void);
			void Dispose(void);

			void Clear(void);

			void AddMsgData(MsgData* i_lpMd);
			void SetMsgDataById(UINT i_idx,MsgData* i_lpMd);

			//数据长度超过255，则用此方法分包
			//void SplitMsgData(char* i_lpChar,USHORT i_usLength);
			void JoinMsgData(MsgData*& r_lpMd,USHORT i_usLength,char* i_lpCharContent);

			//void PackageHead(char* *r_lpCharMsg);
			void PackageHead(char* &r_lpCharMsg);
			//void PackageMsgData(char* *r_lpCharMsg);
			void PackageMsgData(char* &r_lpCharMsg);

			int PackageData(MsgData* i_lpMd,char* i_lpChar);
			
			void UnPackageMsgData(char* i_lpChar,int i_intTotalLength);
			
		private:
			static const int ConstInt_Length_Of_PackageHead=3;
			static const int ConstInt_Length_Of_PackageContentLength=2;
			static const int ConstInt_Length_Of_PackageAction=1;

			static const int ConstInt_Length_Of_MsgDataHead=2;
			static const int ConstInt_Length_Of_MsgDataContentLength=1;
			static const int ConstInt_Length_Of_MsgDataAction=1;
			static const USHORT ConstUs_Joint_MsgDataAction=255;

		private:
			USHORT _usPackageTotalLength;
			USHORT _usUnverifiedPackageTotalLength;
			USHORT _usPackageAction;
			std::vector<MsgData*> _vMsgData;
			char* _lpCharPackaged;

			char* _lpCharReturnPackaged;
			std::string* _lpStrRetuanPackagedToInt;

			//bool _bIsUnpackage;
		};
	}
}