# Math_Calc
using XSLT1.0 supplying mathematic calculable library on XML

# XSLT 1.0 Mathematic calculate function library Project



このライブラリは、XSLT1.0を用いてXML上で数学計算を可能とするライブラリである。

This library is using XSLT1.0 supplying mathematic calculable on XML.

使い方は、XSLTから"xsl:include"で読み込んで使う。

How to use this library is referance call as "xsl:include" for your XSLT.

実装済み関数　Implemented formulas


+ cos(arg)
+ exp(arg)
+ sqrt(arg)
+ ln(arg)


+ sin(arg)
+ tan(arg)
+ log(base,arg)
+ pow(base,arg)


定義済みグローバル変数　Predefined global variables

+ $BIG_NUM (for increase precision number)
+ $MAX_VALUE (don't use calculation number)
+ π $Math_PI
+ exp(1) $Math_E
+ ln(2) $Math_LN2

Demo [https://mu-tan8.github.io/Math_Calc/math_calc.xml]
