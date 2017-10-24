﻿# Math_Calc
using XSLT1.0 supplying mathematic calculable library on XML

# XSLT 1.0 Mathematic calculate function library Project



このライブラリは、XSLT1.0を用いてXML上で数学計算を可能とするライブラリである。

This library is using XSLT1.0 supplying mathematic calculable on XML.

使い方は、XSLTから"xsl:include"で読み込んで使う。

How to use this library is referance call as "xsl:include" for your XSLT.


### ライブラリ利用条件　Library use License


+ 無償利用　Free use
+ 無保証　No guarantee
+ 改変可能　Modifiable
+ 改変時の著作権継承　Inheritance of copyright (modified)
+ 参考資料の明記　specify the Reference materials
+ ファイル名の変更自由　renameable filename


このライブラリを用いて創られた著作物の権利は利用者自身に帰属する

The rights of the work created using this library belong to the user. 


### 実装済み関数　Implemented formulas


+ cos(arg)
+ exp(arg)
+ sqrt(arg) arg > 0
+ ln(arg) arg > 0
+ atan(arg)
+ cosh(arg)

+ sin(arg)
+ tan(arg)
+ acos(arg) -1 < arg <= 1
+ asin(arg)
+ tanh(arg)
+ sinh(arg)
+ asinh(arg)
+ atanh(arg) -1 < arg < 1
+ acosh(arg) arg > 1
+ log(base,arg) base > 0 , arg > 0
+ pow(base,arg) base > 0


+ sgn(arg) 
+ abs(arg) 


### 定義済みグローバル変数　Predefined global variables

+ (for increase precision number) $BIG_NUM = 10^(56)
+ (don't use calculation number) $MAX_VALUE = 10^(308)
+ π $Math_PI = 3.14159265358979
+ exp(1) $Math_E = 2.718281828459045
+ ln(2) $Math_LN2 = 0.693147180559945

Home Page [https://mu-tan8.github.io/Math_Calc/]

Demo Page [https://mu-tan8.github.io/Math_Calc/math_calc.xml]
