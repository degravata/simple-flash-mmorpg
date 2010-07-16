#pragma once
#include "BaseBehaviorMsgSend.h"

namespace SevenSmile{
	namespace Net{
		namespace IOCPFramework{
			namespace BaseBehavior{
				BaseBehaviorMsgSend::BaseBehaviorMsgSend(){
				}
				BaseBehaviorMsgSend::~BaseBehaviorMsgSend(){
				}

				void  BaseBehaviorMsgSend::Remove(IOCP_IO* lp_io){
					this->_ioSendGroup.RemoveAt(lp_io);
				}

				bool BaseBehaviorMsgSend::Send(
					IOCP_IO* i_lp_io,
					char* i_lpChar,
					int i_charArrLength
					)
				{
					DWORD	dwBytes;
					int		nRet;

					//WSABUF wsaBuf;
					//WSAOVERLAPPED ol;

					IOCP_IO* lp_io = _ioSendGroup.GetBlank();
					lp_io->operation=IOCP_WRITE;

					memset(&lp_io->ol,0,sizeof(WSAOVERLAPPED));

					//char msg[BUFFER_SIZE];
					memset(&lp_io->buf,0,BUFFER_SIZE);
					lp_io->wsaBuf.buf	= lp_io->buf;
					lp_io->wsaBuf.len	= BUFFER_SIZE;
					//SOCKET socket;
					//socket=i_soket;

					lp_io->socket=i_lp_io->socket;

					memcpy(lp_io->buf,i_lpChar,i_charArrLength);
					lp_io->wsaBuf.buf =lp_io->buf;
					lp_io->wsaBuf.len=i_charArrLength;

					nRet = WSASend(
						lp_io->socket, 
						&lp_io->wsaBuf,
						1,
						&dwBytes,
						0,
						&lp_io->ol,NULL);

					if((nRet == SOCKET_ERROR)&&(WSAGetLastError() != WSA_IO_PENDING))
					{
						return FALSE;
					}
					return TRUE;
				}

			}
		}
	}
}