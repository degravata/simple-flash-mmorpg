package com.fangtong.Util 
{
	/**
	 * ...
	 * @author fangtong
	 */
	public class StringUtil
	{
		
		public function StringUtil() 
		{
			
		}
		// 最小编辑距离
		/**
		 * 字符串相似度算法（ Levenshtein Distance算法）
		 * @param	s1
		 * @param	s2
		 * @return
		 */
		public static function levenshtein(s1:String, s2:String):int
		{
		     var len1:uint = s1.length;
			 var len2:uint = s2.length;
			 
		     var matrix:Vector.<Vector.<int> > = new Vector.<Vector.<int> >(len1 + 1);
			 var size:int = matrix.length;
			 for (var d:int = 0; d < size; d++  )
				 matrix[d] = new Vector.<int>(len2 + 1);
				 
		     matrix[0][0]=0;
 
			 var i:int = 0, j:int = 0;
		    for(i=1; i<=len1; ++i) matrix[i][0]=i;
		    for(i=1; i<=len2; ++i) matrix[0][i]=i;
 
		    for(i = 1; i <= len1; ++i)
		        for (j = 1; j <= len2; ++j)
					matrix[i][j] = Math.min( 
						//			deletion				insertion
						Math.min(matrix[i - 1][j] + 1, matrix[i][j - 1] + 1),
						//	substitution
						matrix[i - 1][j - 1] + (s1.charAt(i - 1) == s2.charAt(j - 1) ? 0 : 1) 
						);
		    return(matrix[len1][len2]);
		}
	}

}