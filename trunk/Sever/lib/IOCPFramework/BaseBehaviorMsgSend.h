#include "stdafx.h"
#pragma once

namespace SevenSmile{
	namespace Net{
		namespace IOCPFramework{
			namespace BaseBehavior{
				class BaseBehaviorMsgSend{
				private:
				protected:
				public:
					IO_GROUP _ioSendGroup;
					BaseBehaviorMsgSend();
					virtual ~BaseBehaviorMsgSend();
					bool Send(
						IOCP_IO* i_lp_io,
						char* i_lpChar,
						int i_charArrLength
						);
					void Remove(IOCP_IO* lp_io);
				};

			}
		}
	}
}