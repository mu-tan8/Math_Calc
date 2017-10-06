<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
>

<!--

	Mathematic calculate function library

					written by mu-tanθ


	Mathematical constant


	$Math_PI = 3.141592653589793

	$Math_E = 2.718281828459045

	$Math_LN2 = 0.6931471805599453



	mathematic function


	cos([@arg="double:$rad"])
		sin([@arg="double:$rad"])
		tan([@arg="double:$rad"])	
	exp([@arg="double:$real"])
	sqrt([@arg="double:$real"])	arg > 0
	ln([@arg="double:$real"])	arg > 0
		log([@arg="double:$real",@base="double:$real"])	arg > 0 , base > 0
		pow([@arg="double:$real",@base="double:$real"])

	Source :

		乱数と暗号の部屋　（暗号工房）

			from 三角関数・対数関数・指数関数の高速計算法　[ http://www.geocities.jp/midarekazu/cos.html ]


		みずぴー日記

			from log(自然対数)の計算　[ http://d.hatena.ne.jp/mzp/touch/20090925/ln ]

-->

<!--
<xsl:template match="/">
<root>
	<xsl:call-template name="pow">
		<xsl:with-param name="arg" select="-1" />
		<xsl:with-param name="base" select="-2" />
	</xsl:call-template>
</root>
</xsl:template>
-->


<xsl:variable name="MAX_VALUE">100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000</xsl:variable>

<xsl:variable name="BIG_NUM">100000000000000000000000000000000000000000000000000000000</xsl:variable>

<xsl:variable name="Math_PI">
	<xsl:variable name="__a">
		<xsl:call-template name="_pi">
			<xsl:with-param name="cnt" select="0" />
			<xsl:with-param name="max" select="25" />
			<xsl:with-param name="value" select="0" />
		</xsl:call-template>
	</xsl:variable>
	<xsl:value-of select="$__a * 6 * $BIG_NUM div $BIG_NUM" />
</xsl:variable>

<xsl:variable name="Math_E">
	<xsl:call-template name="exp">
		<xsl:with-param name="arg" select="1" />
	</xsl:call-template>
</xsl:variable>

<xsl:variable name="Math_LN2">
	<xsl:call-template name="_ln2">
		<xsl:with-param name="cnt" select="1" />
		<xsl:with-param name="max" select="48" />
		<xsl:with-param name="value" select="0" />
	</xsl:call-template>
</xsl:variable>



<!--	Newton-Raphson Method	-->
<xsl:template name="sqrt">
	<xsl:param name="arg" />
	<xsl:if test="$arg &gt; 0">
		<xsl:call-template name="__while_sqrt">
			<xsl:with-param name="arg" select="$arg" />
			<xsl:with-param name="s" select="1.0" />
			<xsl:with-param name="last_s" select="0.0" />
		</xsl:call-template>
	</xsl:if>
</xsl:template>

	<xsl:template name="__while_sqrt">
		<xsl:param name="arg" />
		<xsl:param name="last_s" />
		<xsl:param name="s" />
		<xsl:choose>
			<xsl:when test="$s != $last_s">
				<xsl:call-template name="__while_sqrt">
					<xsl:with-param name="arg" select="$arg" />
					<xsl:with-param name="last_s" select="$s" />
					<xsl:with-param name="s" select="((($arg div $s) + $s) * $BIG_NUM div 2) div $BIG_NUM" />
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise><xsl:value-of select="$s" /></xsl:otherwise>
		</xsl:choose>
	</xsl:template>
<!--	End Sqrt	-->



<xsl:template name="ln">
	<xsl:param name="arg" />
	<xsl:if test="$arg &gt; 0">
		<xsl:variable name="m" select="20" />
		<xsl:variable name="init" select="2.0 * $BIG_NUM div ($m * 2 + 1)" />
		<xsl:variable name="v1">
			<xsl:call-template name="__while_ln">
				<xsl:with-param name="i" select="0" />
				<xsl:with-param name="n" select="$arg" />
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="n" select="number(substring-before($v1,','))" />
		<xsl:variable name="i" select="number(substring-after($v1,','))" />
		<xsl:variable name="v2">
			<xsl:call-template name="__for_ln">
				<xsl:with-param name="cnt" select="$m - 1" />
				<xsl:with-param name="x" select="(($n - 1.0) * $BIG_NUM div ($n + 1.0)) div $BIG_NUM" />
				<xsl:with-param name="y" select="($init div $BIG_NUM) * (($n - 1.0) * $BIG_NUM div (($n + 1.0)) div $BIG_NUM)" />
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="v3">
			<xsl:call-template name="_pow">
				<xsl:with-param name="cnt" select="0" />
				<xsl:with-param name="pow" select="$i" />
				<xsl:with-param name="base" select="2" />
				<xsl:with-param name="value" select="1" />
			</xsl:call-template>
		</xsl:variable>
		<xsl:value-of select="$v3 * $v2" />
	</xsl:if>
</xsl:template>

	<xsl:template name="__while_ln">
		<xsl:param name="i" />
		<xsl:param name="n" />
		<xsl:variable name="a">
			<xsl:call-template name="abs"><xsl:with-param name="arg" select="$n - 1" /></xsl:call-template>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="$a &gt; 1">
				<xsl:call-template name="__while_ln">
					<xsl:with-param name="i" select="$i + 1" />
					<xsl:with-param name="n">
						<xsl:call-template name="sqrt"><xsl:with-param name="arg" select="$n" /></xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise><xsl:value-of select="$n" />,<xsl:value-of select="$i"/></xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="__for_ln">
		<xsl:param name="cnt" />
		<xsl:param name="x" />
		<xsl:param name="y" />
		<xsl:choose>
			<xsl:when test="$cnt &gt;= 0">
				<xsl:call-template name="__for_ln">
					<xsl:with-param name="cnt" select="$cnt - 1" />
					<xsl:with-param name="x" select="$x" />
					<xsl:with-param name="y" select="$y * ($x * $x) + ((2 * $BIG_NUM div ($cnt * 2 + 1)) * $x)"  />
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise><xsl:value-of select="$y div $BIG_NUM" /></xsl:otherwise>
		</xsl:choose>
	</xsl:template>



<xsl:template name="exp">
	<xsl:param name="arg" />
	<xsl:variable name="m" select="20" />
	<xsl:variable name="init_val">
		<xsl:call-template name="_fact">
			<xsl:with-param name="cnt" select="1" />
			<xsl:with-param name="arg" select="$m" />
			<xsl:with-param name="value" select="1" />
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="v1">
		<xsl:call-template name="_pow">
			<xsl:with-param name="cnt" select="0" />
			<xsl:with-param name="pow" select="$m" />
			<xsl:with-param name="base" select="2" />
			<xsl:with-param name="value" select="1" />
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="v2">
		<xsl:call-template name="__while_exp">
			<xsl:with-param name="p" select="$m - 1" />
			<xsl:with-param name="x" select="($arg * $BIG_NUM div $v1) div $BIG_NUM" />
			<xsl:with-param name="value" select="($BIG_NUM div $init_val) div $BIG_NUM" />
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="v3">
		<xsl:call-template name="__for_exp">
			<xsl:with-param name="i" select="0" />
			<xsl:with-param name="max" select="$m" />
			<xsl:with-param name="value" select="$v2" />
		</xsl:call-template>
	</xsl:variable>
	<xsl:value-of select="$v3 + 1" />
</xsl:template>

	<xsl:template name="__while_exp">
		<xsl:param name="p" />
		<xsl:param name="x" />
		<xsl:param name="value" />
		<xsl:variable name="w">
			<xsl:call-template name="_fact">
				<xsl:with-param name="cnt" select="1" />
				<xsl:with-param name="arg" select="$p" />
				<xsl:with-param name="value" select="1" />
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="y" select="$BIG_NUM div $w" />
		<xsl:choose>
			<xsl:when test="$p &gt; 0">
				<xsl:call-template name="__while_exp">
					<xsl:with-param name="p" select="$p - 1" />
					<xsl:with-param name="x" select="$x" />
					<xsl:with-param name="value" select="($value * $x) + $y" />
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise><xsl:value-of select="($value * $x) div $BIG_NUM" /></xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="__for_exp">
		<xsl:param name="i" />
		<xsl:param name="max" />
		<xsl:param name="value" />
		<xsl:choose>
			<xsl:when test="$i &lt; $max">
				<xsl:call-template name="__for_exp">
					<xsl:with-param name="i" select="$i + 1" />
					<xsl:with-param name="max" select="$max" />
					<xsl:with-param name="value" select="$value * ($value + 2)" />
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise><xsl:value-of select="$value" /></xsl:otherwise>
		</xsl:choose>
	</xsl:template>



<xsl:template name="cos">
	<xsl:param name="arg" />
	<xsl:variable name="m" select="20" />
	<xsl:variable name="init_val">
		<xsl:call-template name="_fact">
			<xsl:with-param name="cnt" select="1" />
			<xsl:with-param name="arg" select="$m * 2" />
			<xsl:with-param name="value" select="1" />
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="init_val_s">
		<xsl:call-template name="_pow">
			<xsl:with-param name="cnt" select="0" />
			<xsl:with-param name="pow" select="$m" />
			<xsl:with-param name="base" select="-1" />
			<xsl:with-param name="value" select="1" />
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="v1">
		<xsl:call-template name="_pow">
			<xsl:with-param name="cnt" select="0" />
			<xsl:with-param name="pow" select="$m" />
			<xsl:with-param name="base" select="2" />
			<xsl:with-param name="value" select="1" />
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="v2">
		<xsl:call-template name="__while_cos">
			<xsl:with-param name="p" select="$m - 1" />
			<xsl:with-param name="x" select="($arg * $BIG_NUM div $v1) div $BIG_NUM" />
			<xsl:with-param name="value" select="($init_val_s * 2 * $BIG_NUM div $init_val) div $BIG_NUM" />
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="v3">
		<xsl:call-template name="__for_cos">
			<xsl:with-param name="i" select="0" />
			<xsl:with-param name="max" select="$m" />
			<xsl:with-param name="value" select="$v2" />
		</xsl:call-template>
	</xsl:variable>
	<xsl:value-of select="1 - ($v3 * $BIG_NUM div 2 ) div $BIG_NUM" />
</xsl:template>

	<xsl:template name="__while_cos">
		<xsl:param name="p" />
		<xsl:param name="x" />
		<xsl:param name="value" />
		<xsl:variable name="w">
			<xsl:call-template name="_fact">
				<xsl:with-param name="cnt" select="1" />
				<xsl:with-param name="arg" select="$p * 2" />
				<xsl:with-param name="value" select="1" />
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="y" select="((2 * $BIG_NUM div $w) div $BIG_NUM)" />
		<xsl:choose>
			<xsl:when test="$p &gt; 0">
				<xsl:call-template name="__while_cos">
					<xsl:with-param name="p" select="$p - 1" />
					<xsl:with-param name="x" select="$x" />
					<xsl:with-param name="value" select="-(($value * ($x * $x)) + $y)" />
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise><xsl:value-of select="-($value * ($x * $x))" /></xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="__for_cos">
		<xsl:param name="i" />
		<xsl:param name="max" />
		<xsl:param name="value" />
		<xsl:choose>
			<xsl:when test="$i &lt; $max">
				<xsl:call-template name="__for_cos">
					<xsl:with-param name="i" select="$i + 1" />
					<xsl:with-param name="max" select="$max" />
					<xsl:with-param name="value" select="$value * (4.0 - $value)" />
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise><xsl:value-of select="$value" /></xsl:otherwise>
		</xsl:choose>
	</xsl:template>



<xsl:template name="_pi">
	<xsl:param name="cnt" select="0" />
	<xsl:param name="max" select="23" />
	<xsl:param name="value" select="0" />
	<xsl:choose>
		<xsl:when test="$cnt &lt; $max">
			<xsl:variable name="v1">
				<xsl:call-template name="_fact">
					<xsl:with-param name="cnt" select="1" />
					<xsl:with-param name="arg" select="$cnt * 2" />
					<xsl:with-param name="value" select="1" />
				</xsl:call-template>
			</xsl:variable>
			<xsl:variable name="v2">
				<xsl:call-template name="_fact">
					<xsl:with-param name="cnt" select="1" />
					<xsl:with-param name="arg" select="$cnt" />
					<xsl:with-param name="value" select="1" />
				</xsl:call-template>
			</xsl:variable>
			<xsl:variable name="v3" select="($v2 * $v2) * ($cnt * 2 + 1)" />
			<xsl:variable name="v4">
				<xsl:call-template name="_pow">
					<xsl:with-param name="cnt" select="0" />
					<xsl:with-param name="pow" select="$cnt * 4 + 1" />
					<xsl:with-param name="base" select="2" />
					<xsl:with-param name="value" select="1" />
				</xsl:call-template>
			</xsl:variable>
			<xsl:call-template name="_pi">
				<xsl:with-param name="cnt" select="$cnt + 1" />
				<xsl:with-param name="max" select="$max" />
				<xsl:with-param name="value" select="$value + ($v1 * $BIG_NUM div ($v4 * $v3))" />
			</xsl:call-template>
		</xsl:when>
		<xsl:otherwise><xsl:value-of select="$value div $BIG_NUM" /></xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template name="_ln2">
	<xsl:param name="cnt" />
	<xsl:param name="max" />
	<xsl:param name="value" />
	<xsl:variable name="p">
		<xsl:call-template name="_pow">
			<xsl:with-param name="cnt" select="0" />
			<xsl:with-param name="pow" select="$cnt" />
			<xsl:with-param name="base" select="2" />
			<xsl:with-param name="value" select="1" />
		</xsl:call-template>
	</xsl:variable>
	<xsl:choose>
		<xsl:when test="$cnt &lt;= $max">
			<xsl:call-template name="_ln2">
				<xsl:with-param name="cnt" select="$cnt + 1" />
				<xsl:with-param name="max" select="$max" />
				<xsl:with-param name="value" select="$value + (1 * $BIG_NUM div ($cnt * $p))" />
			</xsl:call-template>
		</xsl:when>
		<xsl:otherwise><xsl:value-of select="$value div $BIG_NUM" /></xsl:otherwise>
	</xsl:choose>
</xsl:template>



<xsl:template name="pow">
	<xsl:param name="arg" />
	<xsl:param name="base" />
	<xsl:variable name="lnC">
		<xsl:call-template name="ln">
			<xsl:with-param name="arg" select="$base" />
		</xsl:call-template>
	</xsl:variable>
	<xsl:call-template name="exp">
		<xsl:with-param name="arg" select="$arg * $lnC" />
	</xsl:call-template>
</xsl:template>

<xsl:template name="log">
	<xsl:param name="base" />
	<xsl:param name="arg" />
	<xsl:variable name="LNB">
		<xsl:call-template name="ln">
			<xsl:with-param name="arg" select="$base" />
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="LNA">
		<xsl:call-template name="ln">
			<xsl:with-param name="arg" select="$arg" />
		</xsl:call-template>
	</xsl:variable>
	<xsl:value-of select="$LNA div $LNB" />
</xsl:template>

<xsl:template name="sin">
	<xsl:param name="arg" />
	<xsl:variable name="max" select="20" />
	<xsl:call-template name="cos">
		<xsl:with-param name="arg" select="($Math_PI * $BIG_NUM) div (2 * $BIG_NUM) - $arg" />
	</xsl:call-template>
</xsl:template>

<xsl:template name="tan">
	<xsl:param name="arg" />
	<xsl:variable name="max" select="20" />
	<xsl:variable name="c">
		<xsl:call-template name="cos">
			<xsl:with-param name="arg" select="$arg" />
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="s">
		<xsl:call-template name="cos">
			<xsl:with-param name="arg" select="(($Math_PI * $BIG_NUM) div 2) div $BIG_NUM - $arg" />
		</xsl:call-template>
	</xsl:variable>
	<xsl:value-of select="($s * $BIG_NUM div $c) div $BIG_NUM" />
</xsl:template>


<xsl:template name="sgn">
	<xsl:param name="arg" />
	<xsl:value-of select="($arg &gt; 0) - ($arg &lt; 0)" />
</xsl:template>

<xsl:template name="abs">
	<xsl:param name="arg" />
	<xsl:variable name="s">
		<xsl:call-template name="sgn">
			<xsl:with-param name="arg" select="$arg" />
		</xsl:call-template>
	</xsl:variable>
	<xsl:value-of select="$arg * $s" />
</xsl:template>



<xsl:template name="_pow">
	<xsl:param name="cnt" select="0" />
	<xsl:param name="pow" />
	<xsl:param name="base" />
	<xsl:param name="value" select="1" />
	<xsl:variable name="max">
		<xsl:call-template name="abs">
			<xsl:with-param name="arg" select="$pow" />
		</xsl:call-template>
	</xsl:variable>
	<xsl:choose>
		<xsl:when test="$cnt &lt; $max">
			<xsl:call-template name="_pow">
				<xsl:with-param name="cnt" select="$cnt + 1" />
				<xsl:with-param name="pow" select="$pow" />
				<xsl:with-param name="base" select="$base" />
				<xsl:with-param name="value">
					<xsl:choose>
						<xsl:when test="$pow &lt; 0"><xsl:value-of select="$value div $base" /></xsl:when>
						<xsl:otherwise><xsl:value-of select="$value * $base" /></xsl:otherwise>
					</xsl:choose>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:when>
		<xsl:otherwise><xsl:value-of select="$value" /></xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template name="_fact">
	<xsl:param name="cnt" select="1" />
	<xsl:param name="arg" />
	<xsl:param name="value" select="1" />
	<xsl:if test="$arg &gt;= 0">
		<xsl:choose>
			<xsl:when test="$cnt &lt;= $arg">
				<xsl:call-template name="_fact">
					<xsl:with-param name="cnt" select="$cnt + 1" />
					<xsl:with-param name="arg" select="$arg" />
					<xsl:with-param name="value" select="$cnt * $value" />
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise><xsl:value-of select="$value" /></xsl:otherwise>
		</xsl:choose>
	</xsl:if>
</xsl:template>

</xsl:stylesheet>
