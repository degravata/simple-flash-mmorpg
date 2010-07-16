#include "MsgPackage.h"
#include <vector>
#pragma once

namespace SevenSmile{
	struct StructMsgPackage{
		char* lpcMsgPackage;
		unsigned int uiPackageLength;
	};

	typedef std::vector<StructMsgPackage*> MsgPackageArr;

	namespace Net{
		

		extern "C" class MsgPackageManage
		{
		public:
			__declspec(dllexport) MsgPackageManage(char* i_lpChar,unsigned int i_uiPackageLength);
			__declspec(dllexport) ~MsgPackageManage(void);

			__declspec(dllexport) MsgPackageArr& GetMsgPackages();
			//MsgPackage* GetMsgPackages();

		private:
			MsgPackageArr _lpMpArr;
			char*		_lpChar;

			void ExeMsgPackage(char* i_lpChar,unsigned int i_uiPackageLength);
		};
	}
}
