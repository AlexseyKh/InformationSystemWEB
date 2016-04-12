<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="/">
    <h1>Экспорт компаний</h1>
    <xsl:for-each select="companys/company">
        <h2>
          <xsl:value-of select="@name"/>
        </h2>
        <xsl:for-each select="department">
          <h3>
            <xsl:value-of select="@name"/>
          </h3>
          <table id="table" width="600" border="2px">
            <thead>
              <tr>
                <td align="center">Имя</td>
                <td align="center">Фамилия</td>
                <td align="center">Должность</td>
                <td align="center">Зарплата</td>
              </tr>
            </thead>
            <tbody>
              <xsl:for-each select="employee">
                <tr>
                  <td align="center">
                    <xsl:value-of select="@firstName"/>
                  </td>
                  <td align="center">
                    <xsl:value-of select="@lastName"/>
                  </td>
                  <td align="center">
                    <xsl:value-of select="@function"/>
                  </td>
                  <td align="center">
                    <xsl:value-of select="@salary"/>
                  </td>
                </tr>
              </xsl:for-each>
            </tbody>
          </table>
        </xsl:for-each>
        <hr/>
        <br/>
    </xsl:for-each>
  </xsl:template>
</xsl:stylesheet>
