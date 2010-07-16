#pragma once
#include <windows.h>

namespace SevenSmile{
	namespace Net{
		class Util
		{
		public:
			__declspec(dllexport) static USHORT ByteToUShortForAs(char i_Char);
			//__declspec(dllexport) static USHORT BytesToUShortForAs(char* i_lpChar);
			//__declspec(dllexport) static UINT BytesToUIntForAs(char* i_lpChar);
			__declspec(dllexport) static short BytesToShortForAs(char* i_lpChar);
			__declspec(dllexport) static USHORT BytesToUShortForAs(char* i_lpChar);
			__declspec(dllexport) static int BytesToIntForAs(char* i_lpChar);
			__declspec(dllexport) static UINT BytesToUIntForAs(char* i_lpChar);
			
			__declspec(dllexport) static char UShortToCharForAs(USHORT i_us);
			__declspec(dllexport) static void UShortToTowCharForAs(USHORT i_us,char* r_lpChar);

			__declspec(dllexport) static void UIntToBytesForAs(UINT i_us,char* r_lpChar);
			__declspec(dllexport) static void IntToBytesForAs(int i_int,char* r_lpChar);
			__declspec(dllexport) static void UShortToBytesForAs(USHORT i_ushort,char* r_lpChar);
			__declspec(dllexport) static void ShortToBytesForAs(short i_short,char* r_lpChar);

		};
	}
}
