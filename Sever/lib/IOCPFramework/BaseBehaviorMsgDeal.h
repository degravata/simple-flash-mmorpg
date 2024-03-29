﻿#include "stdafx.h"
#include "BaseBehaviorMsgSend.h"
#pragma once

namespace SevenSmile{
	namespace Net{
		namespace IOCPFramework{
			namespace BaseBehavior{
				class BaseBehaviorMsgDeal{
				public:
					virtual ~BaseBehaviorMsgDeal(){}

					void SetBehaviorMsgSend(BaseBehaviorMsgSend* obj);
					__declspec(dllexport) bool Send(IOCP_IO* i_iocpIO,char* i_lpChar,int i_charArrLength);

					virtual bool MsgDeal(
						IOCP_IO* i_iocpIO,
						char* i_lpChar,
						int i_charArrLength
						)=0;

					virtual bool MsgQuit(IOCP_IO* i_iocpIO)=0;
				protected:
					BaseBehaviorMsgSend* interfaceBehaviorMsgSend;
				private:

				};
			}
		}
	}
}