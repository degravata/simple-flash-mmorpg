#include "BaseBehaviorMsgDeal.h"

namespace SevenSmile{
	namespace Net{
		namespace IOCPFramework{
			namespace BaseBehavior{
				void BaseBehaviorMsgDeal::SetBehaviorMsgSend(BaseBehaviorMsgSend* obj){
					this->interfaceBehaviorMsgSend=obj;
				}

				bool BaseBehaviorMsgDeal::Send(
					IOCP_IO* i_iocpIO,
					char* i_lpChar,
					int i_charArrLength)
				{
					bool res;
					res=this->interfaceBehaviorMsgSend->Send(i_iocpIO,i_lpChar,i_charArrLength);

					if(res==false){
						this->MsgQuit(i_iocpIO);
					}
					return res;
				}

			}
		}
	}
}