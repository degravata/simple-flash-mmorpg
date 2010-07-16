#include "MsgPackage.h"

namespace SevenSmile{
	namespace Net{
		MsgPackage::MsgPackage(void)
		{
			this->Init();
		}

		//MsgPackage::MsgPackage(char* i_lpChar,USHORT i_usLength)
		//{
		//	this->Init();
		//	_lpCharPackaged=i_lpChar;
		//	_usUnverifiedPackageTotalLength=i_usLength;
		//	//_usPackageTotalLength=i_usLength;

		//	//_bIsUnpackage=true;
		//	this->UnPackage();
		//}

		void MsgPackage::Init(void){
			_usPackageTotalLength=NULL;
			_usPackageAction=0;
			_lpCharPackaged=NULL;
			_lpCharReturnPackaged=NULL;
			_lpStrRetuanPackagedToInt=NULL;
			_usUnverifiedPackageTotalLength=NULL;
			//_bIsUnpackage=false;
		}

		MsgPackage::~MsgPackage(void)
		{
			this->Dispose();
		}

		void MsgPackage::Clear(void){
			this->Dispose();
			this->Init();
		}
		
		void MsgPackage::Dispose(void){
			if (NULL!=_lpCharReturnPackaged){
				delete[] _lpCharReturnPackaged;
				_lpCharReturnPackaged=NULL;
			}

			if (NULL!=_lpStrRetuanPackagedToInt)
			{
				delete _lpStrRetuanPackagedToInt;
				_lpStrRetuanPackagedToInt=NULL;
			}

			UINT size=_vMsgData.size();
			if(size==0)
			{
				return;
			}
			for (UINT i=0;i<size;i++)
			{
				if(NULL!=_vMsgData[i]->content){
					delete[] _vMsgData[i]->content;
					_vMsgData[i]->content=NULL;
				}

				if(NULL!=_vMsgData[i]){
					delete _vMsgData[i];
					_vMsgData[i]=NULL;
				}
			}
			_vMsgData.clear();
		}

		/************************************************************************/
		/* 以下是解包用到的                                                     */
		/************************************************************************/
		USHORT MsgPackage::GetPackageTotalLength(void){
			if (NULL==_usPackageTotalLength){
				_usPackageTotalLength=Util::BytesToUShortForAs(_lpCharPackaged);
			}

			//if (NULL!=_usUnverifiedPackageTotalLength){
			//	_usPackageTotalLength=
			//		_usPackageTotalLength>=_usUnverifiedPackageTotalLength?_usUnverifiedPackageTotalLength:_usPackageTotalLength;
			//}

			return _usPackageTotalLength;
		}

		USHORT MsgPackage::GetPackageAction(void){
			if (NULL==_usPackageAction){
				_usPackageAction=Util::ByteToUShortForAs(_lpCharPackaged[0+ConstInt_Length_Of_PackageContentLength]);
			}

			return _usPackageAction;
		}

		bool MsgPackage::UnPackage(char* i_lpChar,USHORT i_usLength){
			this->Clear();
			_lpCharPackaged=i_lpChar;
			_usUnverifiedPackageTotalLength=i_usLength;

			int intTotalLength=GetPackageTotalLength();

			if (intTotalLength==i_usLength)
			{
				_usPackageAction=Util::ByteToUShortForAs(_lpCharPackaged[0+ConstInt_Length_Of_PackageContentLength]);

				int intContentLength=intTotalLength-ConstInt_Length_Of_PackageHead;
				char* chArrActions=new char[intContentLength];
				memcpy(chArrActions,_lpCharPackaged+ConstInt_Length_Of_PackageHead,intContentLength);

				this->UnPackageMsgData(chArrActions,intContentLength);

				delete chArrActions;
				chArrActions=NULL;

				return true;
			}

			return false;
		}

		void MsgPackage::UnPackageMsgData(char* i_lpChar,int i_intTotalLength){
			if (i_intTotalLength>0){
				USHORT usMsgDataLength = Util::ByteToUShortForAs(i_lpChar[0]);
				if (usMsgDataLength<=i_intTotalLength && usMsgDataLength>ConstInt_Length_Of_MsgDataHead){
					USHORT usMsgDataAction = Util::ByteToUShortForAs(i_lpChar[ConstInt_Length_Of_MsgDataContentLength]);
					if (usMsgDataAction==ConstUs_Joint_MsgDataAction){
						//_vMsgData[_vMsgData.size()-1]
						if (_vMsgData.size()>0){
							JoinMsgData(_vMsgData[_vMsgData.size()-1],usMsgDataLength,i_lpChar);
						}
					}
					else{
						MsgData* md = new MsgData();
						char* lpCharMsgData = new char[usMsgDataLength-ConstInt_Length_Of_MsgDataHead];
						memcpy(
							lpCharMsgData,
							i_lpChar+ConstInt_Length_Of_MsgDataHead,
							usMsgDataLength-ConstInt_Length_Of_MsgDataHead);

						md->length = usMsgDataLength;
						md->action = usMsgDataAction;
						md->content = lpCharMsgData;
						_vMsgData.push_back(md);
					}

					UnPackageMsgData(
						i_lpChar+usMsgDataLength,
						i_intTotalLength-usMsgDataLength
						);
				}
			}
		}

		void MsgPackage::JoinMsgData(MsgData*& r_lpMd,USHORT i_usMsgDataLength,char* i_lpChar){
			UINT uiNewContentLength=
				r_lpMd->length-ConstInt_Length_Of_MsgDataHead+i_usMsgDataLength-ConstInt_Length_Of_MsgDataHead;
			UINT uiOldContentLength=r_lpMd->length-ConstInt_Length_Of_MsgDataHead;
			
			char* lpChar=new char[uiNewContentLength];
			memcpy(lpChar,r_lpMd->content,uiOldContentLength);
			if (NULL!=r_lpMd->content){
				delete r_lpMd->content;
				r_lpMd->content=NULL;
			}
			memcpy(
				lpChar+uiOldContentLength,
				i_lpChar+ConstInt_Length_Of_MsgDataHead,
				i_usMsgDataLength-ConstInt_Length_Of_MsgDataHead);

			r_lpMd->length=uiNewContentLength+ConstInt_Length_Of_MsgDataHead;
			r_lpMd->content=lpChar;
		}

		UINT MsgPackage::GetMsgDatasNum(void){
			return _vMsgData.size();
		}

		MsgData* MsgPackage::GetMsgDataByAction(USHORT i_usAction){
			for (UINT i=0;i<_vMsgData.size();i++){
				if (_vMsgData[i]->action==i){
					return _vMsgData[i];
				}
			}

			return NULL;
		}

		MsgData* MsgPackage::GetMsgDataById(UINT i){
			if (i<_vMsgData.size()){
				return _vMsgData[i];
			}
			else{
				return NULL;
			}
		}

		std::vector<MsgData*> MsgPackage::GetMsgDatas(void){
			return _vMsgData;
		}

		/*USHORT MsgPackage::ByteToUShortForAs(char i_Char){
			USHORT r=i_Char & 0xFF;
			return r;
		}

		USHORT MsgPackage::BytesToUShortForAs(char* i_lpChar){
			USHORT addr = i_lpChar[1] & 0xFF;
			addr |= ((i_lpChar[0] << 8) & 0xFF00);
			return addr;
		}

		UINT MsgPackage::BytesToUIntForAs(char* i_lpChar){
			int addr = i_lpChar[3] & 0xFF;
			addr |= ((i_lpChar[2] << 8) & 0xFF00);
			addr |= ((i_lpChar[1] << 16) & 0xFF0000);
			addr |= ((i_lpChar[0] << 24) & 0xFF000000);
			return addr;
		}*/

		/************************************************************************/
		/* 以下是封包用到的                                                     */
		/************************************************************************/
		void MsgPackage::SetPackageAction(USHORT i_usHeadAction){
			this->Clear();
			_usPackageTotalLength=ConstInt_Length_Of_PackageHead;
			_usPackageAction=i_usHeadAction;
		}

		void MsgPackage::AddMsgData(USHORT i_usAction){
			MsgData* lpMdAction=new MsgData();
			lpMdAction->length=ConstInt_Length_Of_MsgDataHead;

			lpMdAction->action=i_usAction;
			lpMdAction->content=NULL;
			AddMsgData(lpMdAction);
			//_vMsgData.push_back(lpMdAction);
			//_usPackageTotalLength+=lpMdAction->length;
		}

		//void MsgPackage::AddMsgData(USHORT i_usAction,UINT i_intData){
		//	char* charArrIntData=new char[4];
		//	UINTToBytesForAs(i_intData,charArrIntData);
		//	AddMsgData(i_usAction,charArrIntData,4);
		//}

		void MsgPackage::AddMsgData(USHORT i_usAction,int i_intData){
			if (i_intData>=SCHAR_MIN && i_intData<=SCHAR_MAX){	//-128~127之间
				AddMsgDataChar(i_usAction,(char)i_intData);
			}
			else if(i_intData>SCHAR_MAX && i_intData<=UCHAR_MAX){	//128~255之间
				AddMsgDataCharU(i_usAction,(UCHAR)i_intData);
			}
			else if(i_intData>=SHRT_MIN && i_intData<=SHRT_MAX){	//–32768~32767
				AddMsgDataShort(i_usAction,(short)i_intData);
			}
			else if(i_intData>SHRT_MAX && i_intData<=USHRT_MAX){	//32768~65535
				AddMsgDataShortU(i_usAction,(USHORT)i_intData);
			}
			else if(i_intData>=INT_MIN && i_intData<=INT_MAX){	//–2147483648~2147483647
				AddMsgDataInt(i_usAction,i_intData);
			}
			//else if(i_intData>INT_MAX && i_intData<=UINT_MAX){	//2147483647~4294967295
			//	AddMsgDataUInt(i_usAction,(UINT)i_intData);
			//}
			//else{
			//	//超出长度限制；
			//}
		}

		void MsgPackage::AddMsgData(USHORT i_usAction,UINT i_uintData){
			if(i_uintData>=0 && i_uintData<=UCHAR_MAX){	//0~255之间
				AddMsgDataCharU(i_usAction,(UCHAR)i_uintData);
			}
			else if(i_uintData>UCHAR_MAX && i_uintData<=USHRT_MAX){	//256~65535
				AddMsgDataShortU(i_usAction,(USHORT)i_uintData);
			}
			else if(i_uintData>USHRT_MAX && i_uintData<=UINT_MAX){	//65536~4294967295
				AddMsgDataIntU(i_usAction,(UINT)i_uintData);
			}
			else{
				//超出长度限制；
			}
		}

		void MsgPackage::AddMsgDataIntU(USHORT i_usAction,UINT i_uintData){
			char* charArrIntData=new char[4];
			Util::UIntToBytesForAs(i_uintData,charArrIntData);
			AddMsgData(i_usAction,charArrIntData,4);
		}
		void MsgPackage::AddMsgDataInt(USHORT i_usAction,int i_intData){
			char* charArrIntData=new char[4];
			Util::IntToBytesForAs(i_intData,charArrIntData);
			AddMsgData(i_usAction,charArrIntData,4);
		}
		void MsgPackage::AddMsgDataShortU(USHORT i_usAction,USHORT i_ushortData){
			char* charArrIntData=new char[2];
			Util::UShortToBytesForAs(i_ushortData,charArrIntData);
			AddMsgData(i_usAction,charArrIntData,2);
		}
		void MsgPackage::AddMsgDataShort(USHORT i_usAction,short i_shortData){
			char* charArrIntData=new char[2];
			Util::ShortToBytesForAs(i_shortData,charArrIntData);
			AddMsgData(i_usAction,charArrIntData,2);
		}
		void MsgPackage::AddMsgDataCharU(USHORT i_usAction,UCHAR i_ubyteData){
			char* charArrIntData=new char[1];
			charArrIntData[0]=i_ubyteData;
			AddMsgData(i_usAction,charArrIntData,1);
		}
		void MsgPackage::AddMsgDataChar(USHORT i_usAction,char i_byteData){
			char* charArrIntData=new char[1];
			charArrIntData[0]=i_byteData;
			AddMsgData(i_usAction,charArrIntData,1);
		}

		void MsgPackage::AddMsgData(USHORT i_usAction,char* i_lpCharContent,USHORT i_usContentLength){
			if (NULL==i_lpCharContent){
				return;
			}
			if (i_usContentLength<=0){
				return;
			}

			//if (i_usAction==255){
			//	return;
			//}

			MsgData* lpMdAction=new MsgData();
			lpMdAction->length=i_usContentLength+ConstInt_Length_Of_MsgDataHead;
			lpMdAction->action=i_usAction;

			UINT uintSpliteContentLen=0;
			if (lpMdAction->length>255){
				lpMdAction->length=255;
				uintSpliteContentLen=255-ConstInt_Length_Of_MsgDataHead;
				//截取数据
				char* lpCharTemp=new char[uintSpliteContentLen];
				memcpy(lpCharTemp,i_lpCharContent,uintSpliteContentLen);
				lpMdAction->content=lpCharTemp;
				AddMsgData(lpMdAction);
				AddMsgData(ConstUs_Joint_MsgDataAction,i_lpCharContent+uintSpliteContentLen,i_usContentLength-uintSpliteContentLen);
				//SplitMsgData(i_lpCharContent+uintSpliteContentLen,i_usContentLength-uintSpliteContentLen);
			}
			else{
				lpMdAction->content=i_lpCharContent;
				AddMsgData(lpMdAction);
			}
		}

		//void MsgPackage::SplitMsgData(char* i_lpChar,USHORT i_usLength){
		//	if (NULL==i_lpChar){
		//		return;
		//	}
		//	if (i_usLength<=0){
		//		return ;
		//	}

		//	UINT uintSpliteContentLen=0;

		//	MsgData* lpMdAction=new MsgData();
		//	lpMdAction->length=i_usLength+ConstInt_Length_Of_MsgDataHead;
		//	lpMdAction->action=ConstUs_Joint_MsgDataAction;
		//	if (lpMdAction->length>256){
		//		lpMdAction->length=256;
		//		
		//		//截取数据
		//		uintSpliteContentLen=256-ConstInt_Length_Of_MsgDataHead;

		//		char lpCharTemp[uintSpliteContentLen];
		//		memcpy(lpCharTemp,i_lpChar,uintSpliteContentLen);
		//		lpMdAction->content=lpCharTemp;
		//		//lpMdAction->content=i_lpCharContent;
		//		AddMsgData(lpMdAction);
		//		SplitMsgData(i_lpChar+uintSpliteContentLen,i_usLength-uintSpliteContentLen);
		//	}
		//	else{
		//		lpMdAction->content=i_lpChar;
		//		AddMsgData(lpMdAction);
		//	}
		//}

		//void MsgPackage::SetMsgDataById(UINT i_idx,USHORT i_usAction, char* i_lpCharContent,USHORT i_usContentLength){
		//	if (i_idx<_vMsgData.size()){
		//		_vMsgData[i_idx]->length=i_usContentLength;
		//		_vMsgData[i_idx]->action=i_usAction;
		//		_vMsgData[i_idx]->content=i_lpCharContent;
		//	}
		//}

		void MsgPackage::AddMsgData(MsgData* i_lpMd){
			_vMsgData.push_back(i_lpMd);
			_usPackageTotalLength+=i_lpMd->length;
		}

		//void MsgPackage::SetMsgDataById(UINT i_idx,MsgData* i_lpMd){
		//	if (i_idx<_vMsgData.size()){
		//		_vMsgData[i_idx]->length=i_lpMd->length;
		//		_vMsgData[i_idx]->action=i_lpMd->action;
		//		_vMsgData[i_idx]->content=i_lpMd->content;
		//	}
		//}

		//int MsgPackage::Package(char* *r_lpCharMsg){
		//	PackageMsgData(r_lpCharMsg);
		//	PackageHead(r_lpCharMsg);
		//	for (UINT i=0;i<_vMsgData.size();i++)
		//	{
		//		delete _vMsgData[i];
		//		_vMsgData[i]=NULL;
		//	}
		//	_vMsgData.clear();
		//	return _usPackageTotalLength;
		//}

		int MsgPackage::Package(char* &r_lpCharMsg){
			PackageMsgData(r_lpCharMsg);
			PackageHead(r_lpCharMsg);
			for (UINT i=0;i<_vMsgData.size();i++)
			{
				delete _vMsgData[i];
				_vMsgData[i]=NULL;
			}
			_vMsgData.clear();
			return _usPackageTotalLength;
		}

		//void MsgPackage::PackageHead(char* *r_lpCharMsg){
		//	Util::UShortToTowCharForAs(_usPackageTotalLength,*r_lpCharMsg);
		//	(*r_lpCharMsg)[2]=Util::UShortToCharForAs(_usPackageAction);
		//}

		void MsgPackage::PackageHead(char* &r_lpCharMsg){
			Util::UShortToTowCharForAs(_usPackageTotalLength,r_lpCharMsg);
			r_lpCharMsg[2]=Util::UShortToCharForAs(_usPackageAction);
		}

		//void MsgPackage::PackageMsgData(char* *r_lpCharMsg){
		//	char* _lpTempPackaged=new char[_usPackageTotalLength];
		//	int intPos=ConstInt_Length_Of_PackageHead;
		//	int vLength=_vMsgData.size();
		//	for(int i=0;i<vLength;i++){
		//		char lpCharContent[256];
		//		int len=PackageData(_vMsgData[i],lpCharContent);
		//		//USHORT j=_vMsgData[i]->action;
		//		memcpy(_lpTempPackaged+intPos,lpCharContent,len);
		//		intPos+=len;
		//	}
		//	(*r_lpCharMsg)=_lpTempPackaged;
		//}

		void MsgPackage::PackageMsgData(char* &r_lpCharMsg){
			if (0!=_lpCharReturnPackaged){
				r_lpCharMsg=_lpCharReturnPackaged;
			}
			else{
				this->_lpCharReturnPackaged=new char[_usPackageTotalLength];
				//char* _lpTempPackaged=new char[_usPackageTotalLength];
				int intPos=ConstInt_Length_Of_PackageHead;
				int vLength=_vMsgData.size();
				for(int i=0;i<vLength;i++){
					char lpCharContent[256];
					int len=PackageData(_vMsgData[i],lpCharContent);
					//USHORT j=_vMsgData[i]->action;
					memcpy(_lpCharReturnPackaged+intPos,lpCharContent,len);
					intPos+=len;
				}
				r_lpCharMsg=_lpCharReturnPackaged;
			}
		}

		//int MsgPackage::PackageData(MsgData* i_lpMd,char*& i_lpChar){
		//	i_lpChar[0]=UShortToCharForAs(i_lpMd->length);
		//	i_lpChar[1]=UShortToCharForAs(i_lpMd->action);
		//	if (NULL!=i_lpMd->content){
		//		memcpy(i_lpChar+ConstInt_Length_Of_MsgDataHead,i_lpMd->content,i_lpMd->length-ConstInt_Length_Of_MsgDataHead);
		//	}
		//	return i_lpMd->length;
		//}

		int MsgPackage::PackageData(MsgData* i_lpMd,char* i_lpChar){
			i_lpChar[0]=Util::UShortToCharForAs(i_lpMd->length);
			i_lpChar[1]=Util::UShortToCharForAs(i_lpMd->action);
			if (NULL!=i_lpMd->content){
				memcpy(
					i_lpChar+ConstInt_Length_Of_MsgDataHead,
					i_lpMd->content,
					i_lpMd->length-ConstInt_Length_Of_MsgDataHead
					);
			}
			return i_lpMd->length;
		}

		const char* MsgPackage::ToStringPackage()
		{
			if (NULL!=_lpStrRetuanPackagedToInt){
				return _lpStrRetuanPackagedToInt->c_str();
			}
			else{
				//_lpStrRetuanPackagedToInt=new char[this->GetPackageTotalLength()+1];
				_lpStrRetuanPackagedToInt=new std::string;

				char* lpc=NULL;
				char* lpcSplit="|";
				for (int i=0;i<this->GetPackageTotalLength();i++)
				{
					char c=_lpCharReturnPackaged[i];
					int j=c;
					char* lpc=new char[10];
					_itoa_s(j,lpc,10,10);
					_lpStrRetuanPackagedToInt->append(lpc);
					_lpStrRetuanPackagedToInt->append(lpcSplit);
					//_lpcRetuanPackagedToInt[i]=_lpCharReturnPackaged[i];
				}
				if (NULL!=lpc)
				{
					delete[] lpc;
					lpc=NULL;
				}
				
				//_lpStrRetuanPackagedToInt[this->GetPackageTotalLength()]='\0';
				
				//delete[] _lpcRetuanPackagedToInt;
				return _lpStrRetuanPackagedToInt->c_str();
			}
		}

		//char*& MsgPackage::ToStringUnPackage()
		//{
		//	return NULL;
		//}

		//char MsgPackage::UShortToCharForAs(USHORT i_us){
		//	//byte[] abyte0 = new byte[4];
		//	//abyte0[0] = (byte) (0xff & i);
		//	//abyte0[1] = (byte) ((0xff00 & i) >> 8);
		//	//abyte0[2] = (byte) ((0xff0000 & i) >> 16);
		//	//abyte0[3] = (byte) ((0xff000000 & i) >> 24);
		//	//return abyte0;
		//	UCHAR c=(UCHAR) (0xff & i_us);
		//	return c;
		//}

		//void MsgPackage::UShortToTowCharForAs(USHORT i_us,char* r_lpChar){
		//	//r_lpChar[1]=(UCHAR)(0xff & i_us);
		//	//r_lpChar[0]=(UCHAR)((0xff00 & i_us) >> 8);
		//	//char r_lpChar[2];

		//	r_lpChar[1]=(UCHAR)(i_us);
		//	r_lpChar[0]=(UCHAR)(i_us >> 8);

		//	//return r_lpChar;

		//	//byte[] abyte0 = new byte[4];
		//	//abyte0[0] = (byte) (0xff & i);
		//	//abyte0[1] = (byte) ((0xff00 & i) >> 8);
		//	//abyte0[2] = (byte) ((0xff0000 & i) >> 16);
		//	//abyte0[3] = (byte) ((0xff000000 & i) >> 24);
		//	//return abyte0;
		//}

		//void MsgPackage::UINTToBytesForAs(UINT i_us,char* r_lpChar){
		//	//r_lpChar[1]=(UCHAR)(0xff & i_us);
		//	//r_lpChar[0]=(UCHAR)((0xff00 & i_us) >> 8);

		//	r_lpChar[3] = (UCHAR) (0xff & i_us);
		//	r_lpChar[2] = (UCHAR) ((0xff00 & i_us) >> 8);
		//	r_lpChar[1] = (UCHAR) ((0xff0000 & i_us) >> 16);
		//	r_lpChar[0] = (UCHAR) ((0xff000000 & i_us) >> 24);

		//	//byte[] abyte0 = new byte[4];
		//	//abyte0[0] = (byte) (0xff & i);
		//	//abyte0[1] = (byte) ((0xff00 & i) >> 8);
		//	//abyte0[2] = (byte) ((0xff0000 & i) >> 16);
		//	//abyte0[3] = (byte) ((0xff000000 & i) >> 24);
		//	//return abyte0;
		//}
		//void MsgPackage::IntToBytesForAs(int i_int,char* r_lpChar){
		//	r_lpChar[3] = (byte) (0xff & i_int);
		//	r_lpChar[2] = (byte) ((0xff00 & i_int) >> 8);
		//	r_lpChar[1] = (byte) ((0xff0000 & i_int) >> 16);
		//	r_lpChar[0] = (byte) ((0xff000000 & i_int) >> 24);
		//}
		//void MsgPackage::UShortToBytesForAs(USHORT i_ushort,char* r_lpChar){
		//	r_lpChar[1] = (UCHAR) (0xff & i_ushort);
		//	r_lpChar[0] = (UCHAR) ((0xff00 & i_ushort) >> 8);
		//}
		//void MsgPackage::ShortToBytesForAs(short i_short,char* r_lpChar){
		//	r_lpChar[1] = (byte) (0xff & i_short);
		//	r_lpChar[0] = (byte) ((0xff00 & i_short) >> 8);
		//}

	}
}