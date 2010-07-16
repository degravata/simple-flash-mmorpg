#pragma once
#include "Util.h"

namespace SevenSmile{
	namespace Net{
		class MsgData{
		private:
			static const int ConstInt_Length_Of_MsgDataHead=2;
			static const int ConstInt_Length_Of_MsgDataContentLength=1;
			static const int ConstInt_Length_Of_MsgDataAction=1;
		public:
			USHORT length;
			USHORT action;
			char* content;
		public:
			__declspec(dllexport) MsgData(void);
			__declspec(dllexport) ~MsgData(void);

			__declspec(dllexport) char* GetByteArray(void);
			__declspec(dllexport) int MsgData::GetData(void);
			__declspec(dllexport) UINT MsgData::GetDataU(void);

			__declspec(dllexport) char GetByte(void);
			__declspec(dllexport) UCHAR GetByteU(void);
			
		private:
			short GetShort(void);
			USHORT GetShortU(void);
			int GetInt(void);
			UINT GetIntU(void);
		};
	}
}