module parser
import strconv
import github.com.antlr.antlr4.runtime.Go.antlr
const (
_=fmt.printf 
_=reflect.copy 
_=strconv.itoa 
parser_atn=[u16(3 ,) ,24715 ,42794 ,33075 ,47597 ,16764 ,15335 ,30598 ,22884 ,3 ,100 ,245 ,4 ,2 ,9 ,2 ,4 ,3 ,9 ,3 ,4 ,4 ,9 ,4 ,4 ,5 ,9 ,5 ,4 ,6 ,9 ,6 ,4 ,7 ,9 ,7 ,4 ,8 ,9 ,8 ,4 ,9 ,9 ,9 ,4 ,10 ,9 ,10 ,4 ,11 ,9 ,11 ,4 ,12 ,9 ,12 ,4 ,13 ,9 ,13 ,4 ,14 ,9 ,14 ,4 ,15 ,9 ,15 ,4 ,16 ,9 ,16 ,4 ,17 ,9 ,17 ,4 ,18 ,9 ,18 ,4 ,19 ,9 ,19 ,4 ,20 ,9 ,20 ,4 ,21 ,9 ,21 ,4 ,22 ,9 ,22 ,4 ,23 ,9 ,23 ,4 ,24 ,9 ,24 ,4 ,25 ,9 ,25 ,4 ,26 ,9 ,26 ,3 ,2 ,3 ,2 ,5 ,2 ,55 ,10 ,2 ,3 ,2 ,3 ,2 ,3 ,3 ,3 ,3 ,3 ,3 ,3 ,4 ,7 ,4 ,63 ,10 ,4 ,12 ,4 ,14 ,4 ,66 ,11 ,4 ,3 ,4 ,3 ,4 ,6 ,4 ,70 ,10 ,4 ,13 ,4 ,14 ,4 ,71 ,3 ,4 ,7 ,4 ,75 ,10 ,4 ,12 ,4 ,14 ,4 ,78 ,11 ,4 ,3 ,4 ,7 ,4 ,81 ,10 ,4 ,12 ,4 ,14 ,4 ,84 ,11 ,4 ,3 ,5 ,3 ,5 ,3 ,5 ,5 ,5 ,89 ,10 ,5 ,3 ,6 ,3 ,6 ,3 ,7 ,3 ,7 ,3 ,7 ,5 ,7 ,96 ,10 ,7 ,3 ,7 ,3 ,7 ,3 ,7 ,3 ,7 ,3 ,7 ,3 ,7 ,3 ,7 ,3 ,7 ,7 ,7 ,106 ,10 ,7 ,12 ,7 ,14 ,7 ,109 ,11 ,7 ,5 ,7 ,111 ,10 ,7 ,3 ,8 ,5 ,8 ,114 ,10 ,8 ,3 ,8 ,3 ,8 ,3 ,9 ,5 ,9 ,119 ,10 ,9 ,3 ,9 ,3 ,9 ,5 ,9 ,123 ,10 ,9 ,3 ,10 ,3 ,10 ,3 ,10 ,7 ,10 ,128 ,10 ,10 ,12 ,10 ,14 ,10 ,131 ,11 ,10 ,3 ,11 ,3 ,11 ,3 ,11 ,3 ,11 ,3 ,11 ,5 ,11 ,138 ,10 ,11 ,3 ,11 ,3 ,11 ,3 ,11 ,3 ,11 ,7 ,11 ,144 ,10 ,11 ,12 ,11 ,14 ,11 ,147 ,11 ,11 ,3 ,12 ,3 ,12 ,3 ,12 ,3 ,12 ,3 ,12 ,3 ,12 ,3 ,12 ,3 ,12 ,3 ,12 ,5 ,12 ,158 ,10 ,12 ,3 ,12 ,3 ,12 ,5 ,12 ,162 ,10 ,12 ,3 ,12 ,3 ,12 ,3 ,12 ,5 ,12 ,167 ,10 ,12 ,3 ,12 ,3 ,12 ,5 ,12 ,171 ,10 ,12 ,3 ,12 ,3 ,12 ,3 ,12 ,3 ,12 ,3 ,12 ,3 ,12 ,3 ,12 ,5 ,12 ,180 ,10 ,12 ,3 ,12 ,7 ,12 ,183 ,10 ,12 ,12 ,12 ,14 ,12 ,186 ,11 ,12 ,3 ,13 ,3 ,13 ,3 ,13 ,3 ,13 ,3 ,13 ,3 ,13 ,3 ,13 ,3 ,13 ,3 ,13 ,3 ,13 ,3 ,13 ,5 ,13 ,199 ,10 ,13 ,3 ,13 ,3 ,13 ,3 ,13 ,3 ,13 ,3 ,13 ,3 ,13 ,3 ,13 ,3 ,13 ,7 ,13 ,209 ,10 ,13 ,12 ,13 ,14 ,13 ,212 ,11 ,13 ,3 ,14 ,3 ,14 ,3 ,15 ,3 ,15 ,3 ,16 ,3 ,16 ,3 ,17 ,3 ,17 ,3 ,18 ,3 ,18 ,3 ,19 ,3 ,19 ,3 ,20 ,3 ,20 ,3 ,21 ,3 ,21 ,3 ,22 ,3 ,22 ,3 ,22 ,5 ,22 ,233 ,10 ,22 ,3 ,22 ,3 ,22 ,3 ,23 ,3 ,23 ,3 ,24 ,3 ,24 ,3 ,25 ,3 ,25 ,3 ,26 ,3 ,26 ,3 ,26 ,2 ,5 ,20 ,22 ,24 ,27 ,2 ,4 ,6 ,8 ,10 ,12 ,14 ,16 ,18 ,20 ,22 ,24 ,26 ,28 ,30 ,32 ,34 ,36 ,38 ,40 ,42 ,44 ,46 ,48 ,50 ,2 ,14 ,3 ,2 ,92 ,94 ,3 ,2 ,5 ,6 ,4 ,2 ,33 ,33 ,43 ,43 ,4 ,2 ,9 ,9 ,62 ,62 ,5 ,2 ,5 ,6 ,9 ,10 ,62 ,62 ,4 ,2 ,11 ,11 ,34 ,34 ,3 ,2 ,11 ,20 ,5 ,2 ,21 ,22 ,32 ,32 ,66 ,66 ,4 ,2 ,23 ,27 ,87 ,87 ,4 ,2 ,5 ,6 ,28 ,30 ,12 ,2 ,31 ,31 ,36 ,42 ,44 ,44 ,46 ,47 ,49 ,49 ,51 ,57 ,59 ,61 ,63 ,64 ,68 ,79 ,81 ,85 ,6 ,2 ,65 ,65 ,88 ,88 ,90 ,92 ,95 ,96 ,2 ,251 ,2 ,54 ,3 ,2 ,2 ,2 ,4 ,58 ,3 ,2 ,2 ,2 ,6 ,64 ,3 ,2 ,2 ,2 ,8 ,88 ,3 ,2 ,2 ,2 ,10 ,90 ,3 ,2 ,2 ,2 ,12 ,92 ,3 ,2 ,2 ,2 ,14 ,113 ,3 ,2 ,2 ,2 ,16 ,118 ,3 ,2 ,2 ,2 ,18 ,124 ,3 ,2 ,2 ,2 ,20 ,137 ,3 ,2 ,2 ,2 ,22 ,148 ,3 ,2 ,2 ,2 ,24 ,198 ,3 ,2 ,2 ,2 ,26 ,213 ,3 ,2 ,2 ,2 ,28 ,215 ,3 ,2 ,2 ,2 ,30 ,217 ,3 ,2 ,2 ,2 ,32 ,219 ,3 ,2 ,2 ,2 ,34 ,221 ,3 ,2 ,2 ,2 ,36 ,223 ,3 ,2 ,2 ,2 ,38 ,225 ,3 ,2 ,2 ,2 ,40 ,227 ,3 ,2 ,2 ,2 ,42 ,229 ,3 ,2 ,2 ,2 ,44 ,236 ,3 ,2 ,2 ,2 ,46 ,238 ,3 ,2 ,2 ,2 ,48 ,240 ,3 ,2 ,2 ,2 ,50 ,242 ,3 ,2 ,2 ,2 ,52 ,55 ,5 ,6 ,4 ,2 ,53 ,55 ,5 ,4 ,3 ,2 ,54 ,52 ,3 ,2 ,2 ,2 ,54 ,53 ,3 ,2 ,2 ,2 ,55 ,56 ,3 ,2 ,2 ,2 ,56 ,57 ,7 ,2 ,2 ,3 ,57 ,3 ,3 ,2 ,2 ,2 ,58 ,59 ,7 ,100 ,2 ,2 ,59 ,60 ,8 ,3 ,1 ,2 ,60 ,5 ,3 ,2 ,2 ,2 ,61 ,63 ,7 ,3 ,2 ,2 ,62 ,61 ,3 ,2 ,2 ,2 ,63 ,66 ,3 ,2 ,2 ,2 ,64 ,62 ,3 ,2 ,2 ,2 ,64 ,65 ,3 ,2 ,2 ,2 ,65 ,67 ,3 ,2 ,2 ,2 ,66 ,64 ,3 ,2 ,2 ,2 ,67 ,76 ,5 ,8 ,5 ,2 ,68 ,70 ,7 ,3 ,2 ,2 ,69 ,68 ,3 ,2 ,2 ,2 ,70 ,71 ,3 ,2 ,2 ,2 ,71 ,69 ,3 ,2 ,2 ,2 ,71 ,72 ,3 ,2 ,2 ,2 ,72 ,73 ,3 ,2 ,2 ,2 ,73 ,75 ,5 ,8 ,5 ,2 ,74 ,69 ,3 ,2 ,2 ,2 ,75 ,78 ,3 ,2 ,2 ,2 ,76 ,74 ,3 ,2 ,2 ,2 ,76 ,77 ,3 ,2 ,2 ,2 ,77 ,82 ,3 ,2 ,2 ,2 ,78 ,76 ,3 ,2 ,2 ,2 ,79 ,81 ,7 ,3 ,2 ,2 ,80 ,79 ,3 ,2 ,2 ,2 ,81 ,84 ,3 ,2 ,2 ,2 ,82 ,80 ,3 ,2 ,2 ,2 ,82 ,83 ,3 ,2 ,2 ,2 ,83 ,7 ,3 ,2 ,2 ,2 ,84 ,82 ,3 ,2 ,2 ,2 ,85 ,89 ,5 ,10 ,6 ,2 ,86 ,89 ,5 ,12 ,7 ,2 ,87 ,89 ,5 ,20 ,11 ,2 ,88 ,85 ,3 ,2 ,2 ,2 ,88 ,86 ,3 ,2 ,2 ,2 ,88 ,87 ,3 ,2 ,2 ,2 ,89 ,9 ,3 ,2 ,2 ,2 ,90 ,91 ,9 ,2 ,2 ,2 ,91 ,11 ,3 ,2 ,2 ,2 ,92 ,95 ,7 ,45 ,2 ,2 ,93 ,94 ,7 ,80 ,2 ,2 ,94 ,96 ,5 ,14 ,8 ,2 ,95 ,93 ,3 ,2 ,2 ,2 ,95 ,96 ,3 ,2 ,2 ,2 ,96 ,97 ,3 ,2 ,2 ,2 ,97 ,98 ,5 ,46 ,24 ,2 ,98 ,99 ,7 ,86 ,2 ,2 ,99 ,110 ,5 ,20 ,11 ,2 ,100 ,101 ,7 ,67 ,2 ,2 ,101 ,102 ,7 ,35 ,2 ,2 ,102 ,107 ,5 ,16 ,9 ,2 ,103 ,104 ,7 ,4 ,2 ,2 ,104 ,106 ,5 ,16 ,9 ,2 ,105 ,103 ,3 ,2 ,2 ,2 ,106 ,109 ,3 ,2 ,2 ,2 ,107 ,105 ,3 ,2 ,2 ,2 ,107 ,108 ,3 ,2 ,2 ,2 ,108 ,111 ,3 ,2 ,2 ,2 ,109 ,107 ,3 ,2 ,2 ,2 ,110 ,100 ,3 ,2 ,2 ,2 ,110 ,111 ,3 ,2 ,2 ,2 ,111 ,13 ,3 ,2 ,2 ,2 ,112 ,114 ,9 ,3 ,2 ,2 ,113 ,112 ,3 ,2 ,2 ,2 ,113 ,114 ,3 ,2 ,2 ,2 ,114 ,115 ,3 ,2 ,2 ,2 ,115 ,116 ,7 ,90 ,2 ,2 ,116 ,15 ,3 ,2 ,2 ,2 ,117 ,119 ,5 ,30 ,16 ,2 ,118 ,117 ,3 ,2 ,2 ,2 ,118 ,119 ,3 ,2 ,2 ,2 ,119 ,120 ,3 ,2 ,2 ,2 ,120 ,122 ,5 ,50 ,26 ,2 ,121 ,123 ,9 ,4 ,2 ,2 ,122 ,121 ,3 ,2 ,2 ,2 ,122 ,123 ,3 ,2 ,2 ,2 ,123 ,17 ,3 ,2 ,2 ,2 ,124 ,129 ,5 ,20 ,11 ,2 ,125 ,126 ,7 ,4 ,2 ,2 ,126 ,128 ,5 ,20 ,11 ,2 ,127 ,125 ,3 ,2 ,2 ,2 ,128 ,131 ,3 ,2 ,2 ,2 ,129 ,127 ,3 ,2 ,2 ,2 ,129 ,130 ,3 ,2 ,2 ,2 ,130 ,19 ,3 ,2 ,2 ,2 ,131 ,129 ,3 ,2 ,2 ,2 ,132 ,133 ,8 ,11 ,1 ,2 ,133 ,134 ,5 ,26 ,14 ,2 ,134 ,135 ,5 ,20 ,11 ,5 ,135 ,138 ,3 ,2 ,2 ,2 ,136 ,138 ,5 ,22 ,12 ,2 ,137 ,132 ,3 ,2 ,2 ,2 ,137 ,136 ,3 ,2 ,2 ,2 ,138 ,145 ,3 ,2 ,2 ,2 ,139 ,140 ,12 ,4 ,2 ,2 ,140 ,141 ,5 ,34 ,18 ,2 ,141 ,142 ,5 ,20 ,11 ,5 ,142 ,144 ,3 ,2 ,2 ,2 ,143 ,139 ,3 ,2 ,2 ,2 ,144 ,147 ,3 ,2 ,2 ,2 ,145 ,143 ,3 ,2 ,2 ,2 ,145 ,146 ,3 ,2 ,2 ,2 ,146 ,21 ,3 ,2 ,2 ,2 ,147 ,145 ,3 ,2 ,2 ,2 ,148 ,149 ,8 ,12 ,1 ,2 ,149 ,150 ,5 ,24 ,13 ,2 ,150 ,184 ,3 ,2 ,2 ,2 ,151 ,152 ,12 ,5 ,2 ,2 ,152 ,153 ,5 ,32 ,17 ,2 ,153 ,154 ,5 ,22 ,12 ,6 ,154 ,183 ,3 ,2 ,2 ,2 ,155 ,157 ,12 ,4 ,2 ,2 ,156 ,158 ,5 ,26 ,14 ,2 ,157 ,156 ,3 ,2 ,2 ,2 ,157 ,158 ,3 ,2 ,2 ,2 ,158 ,159 ,3 ,2 ,2 ,2 ,159 ,161 ,7 ,58 ,2 ,2 ,160 ,162 ,5 ,30 ,16 ,2 ,161 ,160 ,3 ,2 ,2 ,2 ,161 ,162 ,3 ,2 ,2 ,2 ,162 ,163 ,3 ,2 ,2 ,2 ,163 ,183 ,5 ,22 ,12 ,5 ,164 ,166 ,12 ,7 ,2 ,2 ,165 ,167 ,5 ,26 ,14 ,2 ,166 ,165 ,3 ,2 ,2 ,2 ,166 ,167 ,3 ,2 ,2 ,2 ,167 ,168 ,3 ,2 ,2 ,2 ,168 ,170 ,7 ,48 ,2 ,2 ,169 ,171 ,5 ,30 ,16 ,2 ,170 ,169 ,3 ,2 ,2 ,2 ,170 ,171 ,3 ,2 ,2 ,2 ,171 ,172 ,3 ,2 ,2 ,2 ,172 ,173 ,7 ,7 ,2 ,2 ,173 ,174 ,5 ,18 ,10 ,2 ,174 ,175 ,7 ,8 ,2 ,2 ,175 ,183 ,3 ,2 ,2 ,2 ,176 ,177 ,12 ,6 ,2 ,2 ,177 ,179 ,7 ,50 ,2 ,2 ,178 ,180 ,5 ,26 ,14 ,2 ,179 ,178 ,3 ,2 ,2 ,2 ,179 ,180 ,3 ,2 ,2 ,2 ,180 ,181 ,3 ,2 ,2 ,2 ,181 ,183 ,7 ,65 ,2 ,2 ,182 ,151 ,3 ,2 ,2 ,2 ,182 ,155 ,3 ,2 ,2 ,2 ,182 ,164 ,3 ,2 ,2 ,2 ,182 ,176 ,3 ,2 ,2 ,2 ,183 ,186 ,3 ,2 ,2 ,2 ,184 ,182 ,3 ,2 ,2 ,2 ,184 ,185 ,3 ,2 ,2 ,2 ,185 ,23 ,3 ,2 ,2 ,2 ,186 ,184 ,3 ,2 ,2 ,2 ,187 ,188 ,8 ,13 ,1 ,2 ,188 ,199 ,5 ,44 ,23 ,2 ,189 ,199 ,5 ,48 ,25 ,2 ,190 ,199 ,5 ,42 ,22 ,2 ,191 ,192 ,5 ,28 ,15 ,2 ,192 ,193 ,5 ,24 ,13 ,6 ,193 ,199 ,3 ,2 ,2 ,2 ,194 ,195 ,7 ,7 ,2 ,2 ,195 ,196 ,5 ,20 ,11 ,2 ,196 ,197 ,7 ,8 ,2 ,2 ,197 ,199 ,3 ,2 ,2 ,2 ,198 ,187 ,3 ,2 ,2 ,2 ,198 ,189 ,3 ,2 ,2 ,2 ,198 ,190 ,3 ,2 ,2 ,2 ,198 ,191 ,3 ,2 ,2 ,2 ,198 ,194 ,3 ,2 ,2 ,2 ,199 ,210 ,3 ,2 ,2 ,2 ,200 ,201 ,12 ,4 ,2 ,2 ,201 ,202 ,5 ,38 ,20 ,2 ,202 ,203 ,5 ,24 ,13 ,5 ,203 ,209 ,3 ,2 ,2 ,2 ,204 ,205 ,12 ,3 ,2 ,2 ,205 ,206 ,5 ,36 ,19 ,2 ,206 ,207 ,5 ,24 ,13 ,4 ,207 ,209 ,3 ,2 ,2 ,2 ,208 ,200 ,3 ,2 ,2 ,2 ,208 ,204 ,3 ,2 ,2 ,2 ,209 ,212 ,3 ,2 ,2 ,2 ,210 ,208 ,3 ,2 ,2 ,2 ,210 ,211 ,3 ,2 ,2 ,2 ,211 ,25 ,3 ,2 ,2 ,2 ,212 ,210 ,3 ,2 ,2 ,2 ,213 ,214 ,9 ,5 ,2 ,2 ,214 ,27 ,3 ,2 ,2 ,2 ,215 ,216 ,9 ,6 ,2 ,2 ,216 ,29 ,3 ,2 ,2 ,2 ,217 ,218 ,9 ,7 ,2 ,2 ,218 ,31 ,3 ,2 ,2 ,2 ,219 ,220 ,9 ,8 ,2 ,2 ,220 ,33 ,3 ,2 ,2 ,2 ,221 ,222 ,9 ,9 ,2 ,2 ,222 ,35 ,3 ,2 ,2 ,2 ,223 ,224 ,9 ,10 ,2 ,2 ,224 ,37 ,3 ,2 ,2 ,2 ,225 ,226 ,9 ,11 ,2 ,2 ,226 ,39 ,3 ,2 ,2 ,2 ,227 ,228 ,9 ,12 ,2 ,2 ,228 ,41 ,3 ,2 ,2 ,2 ,229 ,230 ,5 ,40 ,21 ,2 ,230 ,232 ,7 ,7 ,2 ,2 ,231 ,233 ,5 ,18 ,10 ,2 ,232 ,231 ,3 ,2 ,2 ,2 ,232 ,233 ,3 ,2 ,2 ,2 ,233 ,234 ,3 ,2 ,2 ,2 ,234 ,235 ,7 ,8 ,2 ,2 ,235 ,43 ,3 ,2 ,2 ,2 ,236 ,237 ,9 ,13 ,2 ,2 ,237 ,45 ,3 ,2 ,2 ,2 ,238 ,239 ,7 ,89 ,2 ,2 ,239 ,47 ,3 ,2 ,2 ,2 ,240 ,241 ,7 ,89 ,2 ,2 ,241 ,49 ,3 ,2 ,2 ,2 ,242 ,243 ,7 ,89 ,2 ,2 ,243 ,51 ,3 ,2 ,2 ,2 ,28 ,54 ,64 ,71 ,76 ,82 ,88 ,95 ,107 ,110 ,113 ,118 ,122 ,129 ,137 ,145 ,157 ,161 ,166 ,170 ,179 ,182 ,184 ,198 ,208 ,210 ,232 ] 
literal_names=["" ,"';'" ,"','" ,"'-'" ,"'+'" ,"'('" ,"')'" ,"'!'" ,"'~'" ,"'==='" ,"'<'" ,"'<='" ,"'>'" ,"'>='" ,"'='" ,"'=='" ,"'!='" ,"'!=='" ,"'<>'" ,"'&&'" ,"'||'" ,"'<<'" ,"'>>'" ,"'&'" ,"'|'" ,"'^'" ,"'*'" ,"'/'" ,"'%'" ] 
symbolic_names=["" ,"" ,"" ,"" ,"" ,"" ,"" ,"" ,"" ,"" ,"" ,"" ,"" ,"" ,"" ,"" ,"" ,"" ,"" ,"" ,"" ,"" ,"" ,"" ,"" ,"" ,"" ,"" ,"" ,"K_ABS" ,"K_AND" ,"K_ASC" ,"K_BINARY" ,"K_BY" ,"K_CEILING" ,"K_COALESCE" ,"K_CONVERT" ,"K_CONTAINS" ,"K_DATEADD" ,"K_DATEDIFF" ,"K_DATEPART" ,"K_DESC" ,"K_ENDSWITH" ,"K_FILTER" ,"K_FLOOR" ,"K_IIF" ,"K_IN" ,"K_INDEXOF" ,"K_IS" ,"K_ISDATE" ,"K_ISINTEGER" ,"K_ISGUID" ,"K_ISNULL" ,"K_ISNUMERIC" ,"K_LASTINDEXOF" ,"K_LEN" ,"K_LIKE" ,"K_LOWER" ,"K_MAXOF" ,"K_MINOF" ,"K_NOT" ,"K_NOW" ,"K_NTHINDEXOF" ,"K_NULL" ,"K_OR" ,"K_ORDER" ,"K_POWER" ,"K_REGEXMATCH" ,"K_REGEXVAL" ,"K_REPLACE" ,"K_REVERSE" ,"K_ROUND" ,"K_SQRT" ,"K_SPLIT" ,"K_STARTSWITH" ,"K_STRCOUNT" ,"K_STRCMP" ,"K_SUBSTR" ,"K_TOP" ,"K_TRIM" ,"K_TRIMLEFT" ,"K_TRIMRIGHT" ,"K_UPPER" ,"K_UTCNOW" ,"K_WHERE" ,"K_XOR" ,"BOOLEAN_LITERAL" ,"IDENTIFIER" ,"INTEGER_LITERAL" ,"NUMERIC_LITERAL" ,"GUID_LITERAL" ,"MEASUREMENT_KEY_LITERAL" ,"POINT_TAG_LITERAL" ,"STRING_LITERAL" ,"DATETIME_LITERAL" ,"SINGLE_LINE_COMMENT" ,"MULTILINE_COMMENT" ,"SPACES" ,"UNEXPECTED_CHAR" ] 
rule_names=["parse" ,"err" ,"filterExpressionStatementList" ,"filterExpressionStatement" ,"identifierStatement" ,"filterStatement" ,"topLimit" ,"orderingTerm" ,"expressionList" ,"expression" ,"predicateExpression" ,"valueExpression" ,"notOperator" ,"unaryOperator" ,"exactMatchModifier" ,"comparisonOperator" ,"logicalOperator" ,"bitwiseOperator" ,"mathOperator" ,"functionName" ,"functionExpression" ,"literalValue" ,"tableName" ,"columnName" ,"orderByColumnName" ] 
filter_expression_syntax_parser_eof=antlr.token_eof 
filter_expression_syntax_parser_t_0=1 
filter_expression_syntax_parser_t_1=2 
filter_expression_syntax_parser_t_2=3 
filter_expression_syntax_parser_t_3=4 
filter_expression_syntax_parser_t_4=5 
filter_expression_syntax_parser_t_5=6 
filter_expression_syntax_parser_t_6=7 
filter_expression_syntax_parser_t_7=8 
filter_expression_syntax_parser_t_8=9 
filter_expression_syntax_parser_t_9=10 
filter_expression_syntax_parser_t_10=11 
filter_expression_syntax_parser_t_11=12 
filter_expression_syntax_parser_t_12=13 
filter_expression_syntax_parser_t_13=14 
filter_expression_syntax_parser_t_14=15 
filter_expression_syntax_parser_t_15=16 
filter_expression_syntax_parser_t_16=17 
filter_expression_syntax_parser_t_17=18 
filter_expression_syntax_parser_t_18=19 
filter_expression_syntax_parser_t_19=20 
filter_expression_syntax_parser_t_20=21 
filter_expression_syntax_parser_t_21=22 
filter_expression_syntax_parser_t_22=23 
filter_expression_syntax_parser_t_23=24 
filter_expression_syntax_parser_t_24=25 
filter_expression_syntax_parser_t_25=26 
filter_expression_syntax_parser_t_26=27 
filter_expression_syntax_parser_t_27=28 
filter_expression_syntax_parser_k_abs=29 
filter_expression_syntax_parser_k_and=30 
filter_expression_syntax_parser_k_asc=31 
filter_expression_syntax_parser_k_binary=32 
filter_expression_syntax_parser_k_by=33 
filter_expression_syntax_parser_k_ceiling=34 
filter_expression_syntax_parser_k_coalesce=35 
filter_expression_syntax_parser_k_convert=36 
filter_expression_syntax_parser_k_contains=37 
filter_expression_syntax_parser_k_dateadd=38 
filter_expression_syntax_parser_k_datediff=39 
filter_expression_syntax_parser_k_datepart=40 
filter_expression_syntax_parser_k_desc=41 
filter_expression_syntax_parser_k_endswith=42 
filter_expression_syntax_parser_k_filter=43 
filter_expression_syntax_parser_k_floor=44 
filter_expression_syntax_parser_k_iif=45 
filter_expression_syntax_parser_k_in=46 
filter_expression_syntax_parser_k_indexof=47 
filter_expression_syntax_parser_k_is=48 
filter_expression_syntax_parser_k_isdate=49 
filter_expression_syntax_parser_k_isinteger=50 
filter_expression_syntax_parser_k_isguid=51 
filter_expression_syntax_parser_k_isnull=52 
filter_expression_syntax_parser_k_isnumeric=53 
filter_expression_syntax_parser_k_lastindexof=54 
filter_expression_syntax_parser_k_len=55 
filter_expression_syntax_parser_k_like=56 
filter_expression_syntax_parser_k_lower=57 
filter_expression_syntax_parser_k_maxof=58 
filter_expression_syntax_parser_k_minof=59 
filter_expression_syntax_parser_k_not=60 
filter_expression_syntax_parser_k_now=61 
filter_expression_syntax_parser_k_nthindexof=62 
filter_expression_syntax_parser_k_null=63 
filter_expression_syntax_parser_k_or=64 
filter_expression_syntax_parser_k_order=65 
filter_expression_syntax_parser_k_power=66 
filter_expression_syntax_parser_k_regexmatch=67 
filter_expression_syntax_parser_k_regexval=68 
filter_expression_syntax_parser_k_replace=69 
filter_expression_syntax_parser_k_reverse=70 
filter_expression_syntax_parser_k_round=71 
filter_expression_syntax_parser_k_sqrt=72 
filter_expression_syntax_parser_k_split=73 
filter_expression_syntax_parser_k_startswith=74 
filter_expression_syntax_parser_k_strcount=75 
filter_expression_syntax_parser_k_strcmp=76 
filter_expression_syntax_parser_k_substr=77 
filter_expression_syntax_parser_k_top=78 
filter_expression_syntax_parser_k_trim=79 
filter_expression_syntax_parser_k_trimleft=80 
filter_expression_syntax_parser_k_trimright=81 
filter_expression_syntax_parser_k_upper=82 
filter_expression_syntax_parser_k_utcnow=83 
filter_expression_syntax_parser_k_where=84 
filter_expression_syntax_parser_k_xor=85 
filter_expression_syntax_parser_boolean_literal=86 
filter_expression_syntax_parser_identifier=87 
filter_expression_syntax_parser_integer_literal=88 
filter_expression_syntax_parser_numeric_literal=89 
filter_expression_syntax_parser_guid_literal=90 
filter_expression_syntax_parser_measurement_key_literal=91 
filter_expression_syntax_parser_point_tag_literal=92 
filter_expression_syntax_parser_string_literal=93 
filter_expression_syntax_parser_datetime_literal=94 
filter_expression_syntax_parser_single_line_comment=95 
filter_expression_syntax_parser_multiline_comment=96 
filter_expression_syntax_parser_spaces=97 
filter_expression_syntax_parser_unexpected_char=98 
filter_expression_syntax_parser_ruleparse=0 
filter_expression_syntax_parser_ruleerr=1 
filter_expression_syntax_parser_rulefilter_expression_statement_list=2 
filter_expression_syntax_parser_rulefilter_expression_statement=3 
filter_expression_syntax_parser_ruleidentifier_statement=4 
filter_expression_syntax_parser_rulefilter_statement=5 
filter_expression_syntax_parser_ruletop_limit=6 
filter_expression_syntax_parser_ruleordering_term=7 
filter_expression_syntax_parser_ruleexpression_list=8 
filter_expression_syntax_parser_ruleexpression=9 
filter_expression_syntax_parser_rulepredicate_expression=10 
filter_expression_syntax_parser_rulevalue_expression=11 
filter_expression_syntax_parser_rulenot_operator=12 
filter_expression_syntax_parser_ruleunary_operator=13 
filter_expression_syntax_parser_ruleexact_match_modifier=14 
filter_expression_syntax_parser_rulecomparison_operator=15 
filter_expression_syntax_parser_rulelogical_operator=16 
filter_expression_syntax_parser_rulebitwise_operator=17 
filter_expression_syntax_parser_rulemath_operator=18 
filter_expression_syntax_parser_rulefunction_name=19 
filter_expression_syntax_parser_rulefunction_expression=20 
filter_expression_syntax_parser_ruleliteral_value=21 
filter_expression_syntax_parser_ruletable_name=22 
filter_expression_syntax_parser_rulecolumn_name=23 
filter_expression_syntax_parser_ruleorder_by_column_name=24 
)
struct FilterExpressionSyntaxParser {&antlr.BaseParser
}
struct ParseContext {&antlr.BaseParserRuleContext

mut:
parser antlr.Parser 
}
struct ErrContext {&antlr.BaseParserRuleContext

mut:
parser antlr.Parser 
__unexpected_char antlr.Token 
}
// NewFilterExpressionSyntaxParser produces a new parser instance for the optional input antlr.TokenStr
pub fn new_filter_expression_syntax_parser(input antlr.TokenStream) (&FilterExpressionSyntaxParser, ) {mut this:=new(FilterExpressionSyntaxParser ,)  
mut deserializer:=antlr.new_atndeserializer(unsafe { nil } ,)  
mut deserialized_atn:=deserializer.deserialize_from_uint16(parser_atn ,)  
mut decision_to_dfa:=[]*antlr.DFA{len: deserialized_atn.decision_to_state .len }  
for index, ds in  deserialized_atn.decision_to_state  {
decision_to_dfa[index ]=antlr.new_dfa(ds ,index ,)  
}
this.base_parser=antlr.new_base_parser(input ,)  
this.interpreter=antlr.new_parser_atnsimulator(this ,deserialized_atn ,decision_to_dfa ,antlr.new_prediction_context_cache() ,)  
this.rule_names=rule_names  
this.literal_names=literal_names  
this.symbolic_names=symbolic_names  
this.grammar_file_name="FilterExpressionSyntax.g4"  
return this 
}

pub fn new_empty_parse_context() (&ParseContext, ) {mut p:=new(ParseContext ,)  
p.base_parser_rule_context=antlr.new_base_parser_rule_context(unsafe { nil } ,- 1  ,)  
p.rule_index=filter_expression_syntax_parser_ruleparse  
return p 
}

pub fn (mut _ ParseContext) is_parse_context() {}

pub fn new_parse_context(parser antlr.Parser, parent antlr.ParserRuleContext, invokingState int) (&ParseContext, ) {mut p:=new(ParseContext ,)  
p.base_parser_rule_context=antlr.new_base_parser_rule_context(parent ,invokingState ,)  
p.parser=parser  
p.rule_index=filter_expression_syntax_parser_ruleparse  
return p 
}

pub fn (mut s ParseContext) get_parser() (antlr.Parser, ) {return s.parser 
}

pub fn (mut s ParseContext) eof() (antlr.TerminalNode, ) {return s.get_token(filter_expression_syntax_parser_eof ,0 ,) 
}

pub fn (mut s ParseContext) filter_expression_statement_list() (IFilterExpressionStatementListContext, ) {mut t:=s.get_typed_rule_context(reflect.type_of.elem() ,0 ,)  
if t  ==  unsafe { nil }  {
return unsafe { nil } 
}
return t 
}

pub fn (mut s ParseContext) err() (IErrContext, ) {mut t:=s.get_typed_rule_context(reflect.type_of.elem() ,0 ,)  
if t  ==  unsafe { nil }  {
return unsafe { nil } 
}
return t 
}

pub fn (mut s ParseContext) get_rule_context() (antlr.RuleContext, ) {return s 
}

pub fn (mut s ParseContext) to_string_tree(ruleNames []string, recog antlr.Recognizer) (string, ) {return antlr.trees_string_tree(s ,ruleNames ,recog ,) 
}

pub fn (mut s ParseContext) enter_rule(listener antlr.ParseTreeListener) {mut listener_t,ok:=listener 
if ok {
listener_t.enter_parse(s ,)
}
}

pub fn (mut s ParseContext) exit_rule(listener_1 antlr.ParseTreeListener) {mut listener_t,ok:=listener_1 
if ok {
listener_t.exit_parse(s ,)
}
}

pub fn (mut p FilterExpressionSyntaxParser) parse() (IParseContext, ) {mut localctx:=IParseContext{}
localctx=new_parse_context(p ,p.get_parser_rule_context() ,p.get_state() ,)  
p.enter_rule(localctx ,0 ,filter_expression_syntax_parser_ruleparse ,)
defer {p.exit_rule()
}
defer {mut err_1:=recover() 
if err_1  !=  unsafe { nil }  {
mut v,ok:=err_1 
if ok {
localctx.set_exception(v ,)
p.get_error_handler.report_error(p ,v ,)
p.get_error_handler.recover(p ,v ,)
}else {
panic(err_1 ,)
}
}
}
p.enter_outer_alt(localctx ,1 ,)
p.set_state(52 ,)
p.get_error_handler.sync(p ,)
 match p.get_token_stream.la(1 ,) {filter_expression_syntax_parser_t_0 ,filter_expression_syntax_parser_t_2 ,filter_expression_syntax_parser_t_3 ,filter_expression_syntax_parser_t_4 ,filter_expression_syntax_parser_t_6 ,filter_expression_syntax_parser_t_7 ,filter_expression_syntax_parser_k_abs ,filter_expression_syntax_parser_k_ceiling ,filter_expression_syntax_parser_k_coalesce ,filter_expression_syntax_parser_k_convert ,filter_expression_syntax_parser_k_contains ,filter_expression_syntax_parser_k_dateadd ,filter_expression_syntax_parser_k_datediff ,filter_expression_syntax_parser_k_datepart ,filter_expression_syntax_parser_k_endswith ,filter_expression_syntax_parser_k_filter ,filter_expression_syntax_parser_k_floor ,filter_expression_syntax_parser_k_iif ,filter_expression_syntax_parser_k_indexof ,filter_expression_syntax_parser_k_isdate ,filter_expression_syntax_parser_k_isinteger ,filter_expression_syntax_parser_k_isguid ,filter_expression_syntax_parser_k_isnull ,filter_expression_syntax_parser_k_isnumeric ,filter_expression_syntax_parser_k_lastindexof ,filter_expression_syntax_parser_k_len ,filter_expression_syntax_parser_k_lower ,filter_expression_syntax_parser_k_maxof ,filter_expression_syntax_parser_k_minof ,filter_expression_syntax_parser_k_not ,filter_expression_syntax_parser_k_now ,filter_expression_syntax_parser_k_nthindexof ,filter_expression_syntax_parser_k_null ,filter_expression_syntax_parser_k_power ,filter_expression_syntax_parser_k_regexmatch ,filter_expression_syntax_parser_k_regexval ,filter_expression_syntax_parser_k_replace ,filter_expression_syntax_parser_k_reverse ,filter_expression_syntax_parser_k_round ,filter_expression_syntax_parser_k_sqrt ,filter_expression_syntax_parser_k_split ,filter_expression_syntax_parser_k_startswith ,filter_expression_syntax_parser_k_strcount ,filter_expression_syntax_parser_k_strcmp ,filter_expression_syntax_parser_k_substr ,filter_expression_syntax_parser_k_trim ,filter_expression_syntax_parser_k_trimleft ,filter_expression_syntax_parser_k_trimright ,filter_expression_syntax_parser_k_upper ,filter_expression_syntax_parser_k_utcnow ,filter_expression_syntax_parser_boolean_literal ,filter_expression_syntax_parser_identifier ,filter_expression_syntax_parser_integer_literal ,filter_expression_syntax_parser_numeric_literal ,filter_expression_syntax_parser_guid_literal ,filter_expression_syntax_parser_measurement_key_literal ,filter_expression_syntax_parser_point_tag_literal ,filter_expression_syntax_parser_string_literal ,filter_expression_syntax_parser_datetime_literal {
{p.set_state(50 ,)
p.filter_expression_statement_list()
}
}
filter_expression_syntax_parser_unexpected_char {
{p.set_state(51 ,)
p.err()
}
}
else{
panic(antlr.new_no_viable_alt_exception(p ,unsafe { nil } ,unsafe { nil } ,unsafe { nil } ,unsafe { nil } ,unsafe { nil } ,) ,)
}
}
{p.set_state(54 ,)
p.@match(filter_expression_syntax_parser_eof ,)
}
return localctx 
}

pub fn new_empty_err_context() (&ErrContext, ) {mut p:=new(ErrContext ,)  
p.base_parser_rule_context=antlr.new_base_parser_rule_context(unsafe { nil } ,- 1  ,)  
p.rule_index=filter_expression_syntax_parser_ruleerr  
return p 
}

pub fn (mut _ ErrContext) is_err_context() {}

pub fn new_err_context(parser_1 antlr.Parser, parent_1 antlr.ParserRuleContext, invokingState_1 int) (&ErrContext, ) {mut p:=new(ErrContext ,)  
p.base_parser_rule_context=antlr.new_base_parser_rule_context(parent_1 ,invokingState_1 ,)  
p.parser=parser_1  
p.rule_index=filter_expression_syntax_parser_ruleerr  
return p 
}

pub fn (mut s ErrContext) get_parser_1() (antlr.Parser, ) {return s.parser 
}

pub fn (mut s ErrContext) get__unexpected_char() (antlr.Token, ) {return s.__unexpected_char 
}

pub fn (mut s ErrContext) set__unexpected_char(v antlr.Token) {s.__unexpected_char=v  
}

pub fn (mut s ErrContext) unexpected_char() (antlr.TerminalNode, ) {return s.get_token(filter_expression_syntax_parser_unexpected_char ,0 ,) 
}

pub fn (mut s ErrContext) get_rule_context_1() (antlr.RuleContext, ) {return s 
}

pub fn (mut s ErrContext) to_string_tree_1(ruleNames_1 []string, recog_1 antlr.Recognizer) (string, ) {return antlr.trees_string_tree(s ,ruleNames_1 ,recog_1 ,) 
}

pub fn (mut s ErrContext) enter_rule_1(listener_2 antlr.ParseTreeListener) {mut listener_t,ok:=listener_2 
if ok {
listener_t.enter_err(s ,)
}
}

pub fn (mut s ErrContext) exit_rule_1(listener_3 antlr.ParseTreeListener) {mut listener_t,ok:=listener_3 
if ok {
listener_t.exit_err(s ,)
}
}

pub fn (mut p FilterExpressionSyntaxParser) err_1() (IErrContext, ) {mut localctx_1:=IErrContext{}
localctx_1=new_err_context(p ,p.get_parser_rule_context() ,p.get_state() ,)  
p.enter_rule(localctx_1 ,2 ,filter_expression_syntax_parser_ruleerr ,)
defer {p.exit_rule()
}
defer {mut err_2:=recover() 
if err_2  !=  unsafe { nil }  {
mut v_1,ok:=err_2 
if ok {
localctx_1.set_exception(v_1 ,)
p.get_error_handler.report_error(p ,v_1 ,)
p.get_error_handler.recover(p ,v_1 ,)
}else {
panic(err_2 ,)
}
}
}
p.enter_outer_alt(localctx_1 ,1 ,)
{p.set_state(56 ,)
mut _m:=p.@match(filter_expression_syntax_parser_unexpected_char ,)  
localctx_1.__unexpected_char=_m  
}
panic("Unexpected character: "  +  (fn () (string, ) )  ,)
}

pub fn new_empty_filter_expression_statement_list_context() (&ParseContext, ) {mut p:=new(ParseContext ,)  
p.base_parser_rule_context=antlr.new_base_parser_rule_context(unsafe { nil } ,- 1  ,)  
p.rule_index=filter_expression_syntax_parser_rulefilter_expression_statement_list  
return p 
}

pub fn (mut _ ParseContext) is_filter_expression_statement_list_context() {}

pub fn new_filter_expression_statement_list_context(parser_2 antlr.Parser, parent_2 antlr.ParserRuleContext, invokingState_2 int) (&ParseContext, ) {mut p:=new(ParseContext ,)  
p.base_parser_rule_context=antlr.new_base_parser_rule_context(parent_2 ,invokingState_2 ,)  
p.parser=parser_2  
p.rule_index=filter_expression_syntax_parser_rulefilter_expression_statement_list  
return p 
}

pub fn (mut s ParseContext) get_parser_2() (antlr.Parser, ) {return s.parser 
}

pub fn (mut s ParseContext) all_filter_expression_statement() ([]IFilterExpressionStatementContext, ) {mut ts:=s.get_typed_rule_contexts(reflect.type_of.elem() ,)  
mut tst:=[]IFilterExpressionStatementContext{len: ts .len }  
for i, t in  ts  {
if t  !=  unsafe { nil }  {
tst[i ]=t  
}
}
return tst 
}

pub fn (mut s ParseContext) filter_expression_statement(i int) (IFilterExpressionStatementContext, ) {mut t:=s.get_typed_rule_context(reflect.type_of.elem() ,i ,)  
if t  ==  unsafe { nil }  {
return unsafe { nil } 
}
return t 
}

pub fn (mut s ParseContext) get_rule_context_2() (antlr.RuleContext, ) {return s 
}

pub fn (mut s ParseContext) to_string_tree_2(ruleNames_2 []string, recog_2 antlr.Recognizer) (string, ) {return antlr.trees_string_tree(s ,ruleNames_2 ,recog_2 ,) 
}

pub fn (mut s ParseContext) enter_rule_2(listener_4 antlr.ParseTreeListener) {mut listener_t,ok:=listener_4 
if ok {
listener_t.enter_filter_expression_statement_list(s ,)
}
}

pub fn (mut s ParseContext) exit_rule_2(listener_5 antlr.ParseTreeListener) {mut listener_t,ok:=listener_5 
if ok {
listener_t.exit_filter_expression_statement_list(s ,)
}
}

pub fn (mut p FilterExpressionSyntaxParser) filter_expression_statement_list_1() (IFilterExpressionStatementListContext, ) {mut localctx_2:=IFilterExpressionStatementListContext{}
localctx_2=new_filter_expression_statement_list_context(p ,p.get_parser_rule_context() ,p.get_state() ,)  
p.enter_rule(localctx_2 ,4 ,filter_expression_syntax_parser_rulefilter_expression_statement_list ,)
mut _la:=0 
defer {p.exit_rule()
}
defer {mut err_2:=recover() 
if err_2  !=  unsafe { nil }  {
mut v_1,ok:=err_2 
if ok {
localctx_2.set_exception(v_1 ,)
p.get_error_handler.report_error(p ,v_1 ,)
p.get_error_handler.recover(p ,v_1 ,)
}else {
panic(err_2 ,)
}
}
}
mut _alt:=0 
p.enter_outer_alt(localctx_2 ,1 ,)
p.set_state(62 ,)
p.get_error_handler.sync(p ,)
_la=p.get_token_stream.la(1 ,)  
for _la  ==  filter_expression_syntax_parser_t_0  {
{p.set_state(59 ,)
p.@match(filter_expression_syntax_parser_t_0 ,)
}
p.set_state(64 ,)
p.get_error_handler.sync(p ,)
_la=p.get_token_stream.la(1 ,)  
}
{p.set_state(65 ,)
p.filter_expression_statement()
}
p.set_state(74 ,)
p.get_error_handler.sync(p ,)
_alt=p.get_interpreter.adaptive_predict(p.get_token_stream() ,3 ,p.get_parser_rule_context() ,)  
for _alt  !=  2   &&  _alt  !=  antlr.atninvalid_alt_number   {
if _alt  ==  1  {
p.set_state(67 ,)
p.get_error_handler.sync(p ,)
_la=p.get_token_stream.la(1 ,)  
for ok:=true  ;ok ;ok=_la  ==  filter_expression_syntax_parser_t_0    {
{p.set_state(66 ,)
p.@match(filter_expression_syntax_parser_t_0 ,)
}
p.set_state(69 ,)
p.get_error_handler.sync(p ,)
_la=p.get_token_stream.la(1 ,)  
}
{p.set_state(71 ,)
p.filter_expression_statement()
}
}
p.set_state(76 ,)
p.get_error_handler.sync(p ,)
_alt=p.get_interpreter.adaptive_predict(p.get_token_stream() ,3 ,p.get_parser_rule_context() ,)  
}
p.set_state(80 ,)
p.get_error_handler.sync(p ,)
_la=p.get_token_stream.la(1 ,)  
for _la  ==  filter_expression_syntax_parser_t_0  {
{p.set_state(77 ,)
p.@match(filter_expression_syntax_parser_t_0 ,)
}
p.set_state(82 ,)
p.get_error_handler.sync(p ,)
_la=p.get_token_stream.la(1 ,)  
}
return localctx_2 
}

pub fn new_empty_filter_expression_statement_context() (&ParseContext, ) {mut p:=new(ParseContext ,)  
p.base_parser_rule_context=antlr.new_base_parser_rule_context(unsafe { nil } ,- 1  ,)  
p.rule_index=filter_expression_syntax_parser_rulefilter_expression_statement  
return p 
}

pub fn (mut _ ParseContext) is_filter_expression_statement_context() {}

pub fn new_filter_expression_statement_context(parser_3 antlr.Parser, parent_3 antlr.ParserRuleContext, invokingState_3 int) (&ParseContext, ) {mut p:=new(ParseContext ,)  
p.base_parser_rule_context=antlr.new_base_parser_rule_context(parent_3 ,invokingState_3 ,)  
p.parser=parser_3  
p.rule_index=filter_expression_syntax_parser_rulefilter_expression_statement  
return p 
}

pub fn (mut s ParseContext) get_parser_3() (antlr.Parser, ) {return s.parser 
}

pub fn (mut s ParseContext) identifier_statement() (IIdentifierStatementContext, ) {mut t:=s.get_typed_rule_context(reflect.type_of.elem() ,0 ,)  
if t  ==  unsafe { nil }  {
return unsafe { nil } 
}
return t 
}

pub fn (mut s ParseContext) filter_statement() (IFilterStatementContext, ) {mut t:=s.get_typed_rule_context(reflect.type_of.elem() ,0 ,)  
if t  ==  unsafe { nil }  {
return unsafe { nil } 
}
return t 
}

pub fn (mut s ParseContext) expression() (IExpressionContext, ) {mut t:=s.get_typed_rule_context(reflect.type_of.elem() ,0 ,)  
if t  ==  unsafe { nil }  {
return unsafe { nil } 
}
return t 
}

pub fn (mut s ParseContext) get_rule_context_3() (antlr.RuleContext, ) {return s 
}

pub fn (mut s ParseContext) to_string_tree_3(ruleNames_3 []string, recog_3 antlr.Recognizer) (string, ) {return antlr.trees_string_tree(s ,ruleNames_3 ,recog_3 ,) 
}

pub fn (mut s ParseContext) enter_rule_3(listener_6 antlr.ParseTreeListener) {mut listener_t,ok:=listener_6 
if ok {
listener_t.enter_filter_expression_statement(s ,)
}
}

pub fn (mut s ParseContext) exit_rule_3(listener_7 antlr.ParseTreeListener) {mut listener_t,ok:=listener_7 
if ok {
listener_t.exit_filter_expression_statement(s ,)
}
}

pub fn (mut p FilterExpressionSyntaxParser) filter_expression_statement_1() (IFilterExpressionStatementContext, ) {mut localctx_3:=IFilterExpressionStatementContext{}
localctx_3=new_filter_expression_statement_context(p ,p.get_parser_rule_context() ,p.get_state() ,)  
p.enter_rule(localctx_3 ,6 ,filter_expression_syntax_parser_rulefilter_expression_statement ,)
defer {p.exit_rule()
}
defer {mut err_2:=recover() 
if err_2  !=  unsafe { nil }  {
mut v_1,ok:=err_2 
if ok {
localctx_3.set_exception(v_1 ,)
p.get_error_handler.report_error(p ,v_1 ,)
p.get_error_handler.recover(p ,v_1 ,)
}else {
panic(err_2 ,)
}
}
}
p.set_state(86 ,)
p.get_error_handler.sync(p ,)
 match p.get_interpreter.adaptive_predict(p.get_token_stream() ,5 ,p.get_parser_rule_context() ,) {1 {
p.enter_outer_alt(localctx_3 ,1 ,)
{p.set_state(83 ,)
p.identifier_statement()
}
}
2 {
p.enter_outer_alt(localctx_3 ,2 ,)
{p.set_state(84 ,)
p.filter_statement()
}
}
3 {
p.enter_outer_alt(localctx_3 ,3 ,)
{p.set_state(85 ,)
p.expression(0 ,)
}
}
else{
}
}
return localctx_3 
}

pub fn new_empty_identifier_statement_context() (&ParseContext, ) {mut p:=new(ParseContext ,)  
p.base_parser_rule_context=antlr.new_base_parser_rule_context(unsafe { nil } ,- 1  ,)  
p.rule_index=filter_expression_syntax_parser_ruleidentifier_statement  
return p 
}

pub fn (mut _ ParseContext) is_identifier_statement_context() {}

pub fn new_identifier_statement_context(parser_4 antlr.Parser, parent_4 antlr.ParserRuleContext, invokingState_4 int) (&ParseContext, ) {mut p:=new(ParseContext ,)  
p.base_parser_rule_context=antlr.new_base_parser_rule_context(parent_4 ,invokingState_4 ,)  
p.parser=parser_4  
p.rule_index=filter_expression_syntax_parser_ruleidentifier_statement  
return p 
}

pub fn (mut s ParseContext) get_parser_4() (antlr.Parser, ) {return s.parser 
}

pub fn (mut s ParseContext) guid_literal() (antlr.TerminalNode, ) {return s.get_token(filter_expression_syntax_parser_guid_literal ,0 ,) 
}

pub fn (mut s ParseContext) measurement_key_literal() (antlr.TerminalNode, ) {return s.get_token(filter_expression_syntax_parser_measurement_key_literal ,0 ,) 
}

pub fn (mut s ParseContext) point_tag_literal() (antlr.TerminalNode, ) {return s.get_token(filter_expression_syntax_parser_point_tag_literal ,0 ,) 
}

pub fn (mut s ParseContext) get_rule_context_4() (antlr.RuleContext, ) {return s 
}

pub fn (mut s ParseContext) to_string_tree_4(ruleNames_4 []string, recog_4 antlr.Recognizer) (string, ) {return antlr.trees_string_tree(s ,ruleNames_4 ,recog_4 ,) 
}

pub fn (mut s ParseContext) enter_rule_4(listener_8 antlr.ParseTreeListener) {mut listener_t,ok:=listener_8 
if ok {
listener_t.enter_identifier_statement(s ,)
}
}

pub fn (mut s ParseContext) exit_rule_4(listener_9 antlr.ParseTreeListener) {mut listener_t,ok:=listener_9 
if ok {
listener_t.exit_identifier_statement(s ,)
}
}

pub fn (mut p FilterExpressionSyntaxParser) identifier_statement_1() (IIdentifierStatementContext, ) {mut localctx_4:=IIdentifierStatementContext{}
localctx_4=new_identifier_statement_context(p ,p.get_parser_rule_context() ,p.get_state() ,)  
p.enter_rule(localctx_4 ,8 ,filter_expression_syntax_parser_ruleidentifier_statement ,)
mut _la:=0 
defer {p.exit_rule()
}
defer {mut err_2:=recover() 
if err_2  !=  unsafe { nil }  {
mut v_1,ok:=err_2 
if ok {
localctx_4.set_exception(v_1 ,)
p.get_error_handler.report_error(p ,v_1 ,)
p.get_error_handler.recover(p ,v_1 ,)
}else {
panic(err_2 ,)
}
}
}
p.enter_outer_alt(localctx_4 ,1 ,)
{p.set_state(88 ,)
_la=p.get_token_stream.la(1 ,)  
if ! (((_la  -  90  )  &  - (0x1f  +  1  )   )  ==  0   &&  ((1  <<  uint((_la  -  90  ) ,)  )  &  ((1  <<  (filter_expression_syntax_parser_guid_literal  -  90  )  )  |  (1  <<  (filter_expression_syntax_parser_measurement_key_literal  -  90  )  )   |  (1  <<  (filter_expression_syntax_parser_point_tag_literal  -  90  )  )  )  )  !=  0   )  {
p.get_error_handler.recover_inline(p ,)
}else {
p.get_error_handler.report_match(p ,)
p.consume()
}
}
return localctx_4 
}

pub fn new_empty_filter_statement_context() (&ParseContext, ) {mut p:=new(ParseContext ,)  
p.base_parser_rule_context=antlr.new_base_parser_rule_context(unsafe { nil } ,- 1  ,)  
p.rule_index=filter_expression_syntax_parser_rulefilter_statement  
return p 
}

pub fn (mut _ ParseContext) is_filter_statement_context() {}

pub fn new_filter_statement_context(parser_5 antlr.Parser, parent_5 antlr.ParserRuleContext, invokingState_5 int) (&ParseContext, ) {mut p:=new(ParseContext ,)  
p.base_parser_rule_context=antlr.new_base_parser_rule_context(parent_5 ,invokingState_5 ,)  
p.parser=parser_5  
p.rule_index=filter_expression_syntax_parser_rulefilter_statement  
return p 
}

pub fn (mut s ParseContext) get_parser_5() (antlr.Parser, ) {return s.parser 
}

pub fn (mut s ParseContext) k_filter() (antlr.TerminalNode, ) {return s.get_token(filter_expression_syntax_parser_k_filter ,0 ,) 
}

pub fn (mut s ParseContext) table_name() (ITableNameContext, ) {mut t:=s.get_typed_rule_context(reflect.type_of.elem() ,0 ,)  
if t  ==  unsafe { nil }  {
return unsafe { nil } 
}
return t 
}

pub fn (mut s ParseContext) k_where() (antlr.TerminalNode, ) {return s.get_token(filter_expression_syntax_parser_k_where ,0 ,) 
}

pub fn (mut s ParseContext) expression_1() (IExpressionContext, ) {mut t:=s.get_typed_rule_context(reflect.type_of.elem() ,0 ,)  
if t  ==  unsafe { nil }  {
return unsafe { nil } 
}
return t 
}

pub fn (mut s ParseContext) k_top() (antlr.TerminalNode, ) {return s.get_token(filter_expression_syntax_parser_k_top ,0 ,) 
}

pub fn (mut s ParseContext) top_limit() (ITopLimitContext, ) {mut t:=s.get_typed_rule_context(reflect.type_of.elem() ,0 ,)  
if t  ==  unsafe { nil }  {
return unsafe { nil } 
}
return t 
}

pub fn (mut s ParseContext) k_order() (antlr.TerminalNode, ) {return s.get_token(filter_expression_syntax_parser_k_order ,0 ,) 
}

pub fn (mut s ParseContext) k_by() (antlr.TerminalNode, ) {return s.get_token(filter_expression_syntax_parser_k_by ,0 ,) 
}

pub fn (mut s ParseContext) all_ordering_term() ([]IOrderingTermContext, ) {mut ts:=s.get_typed_rule_contexts(reflect.type_of.elem() ,)  
mut tst:=[]IOrderingTermContext{len: ts .len }  
for i_1, t in  ts  {
if t  !=  unsafe { nil }  {
tst[i_1 ]=t  
}
}
return tst 
}

pub fn (mut s ParseContext) ordering_term(i_1 int) (IOrderingTermContext, ) {mut t:=s.get_typed_rule_context(reflect.type_of.elem() ,i_1 ,)  
if t  ==  unsafe { nil }  {
return unsafe { nil } 
}
return t 
}

pub fn (mut s ParseContext) get_rule_context_5() (antlr.RuleContext, ) {return s 
}

pub fn (mut s ParseContext) to_string_tree_5(ruleNames_5 []string, recog_5 antlr.Recognizer) (string, ) {return antlr.trees_string_tree(s ,ruleNames_5 ,recog_5 ,) 
}

pub fn (mut s ParseContext) enter_rule_5(listener_10 antlr.ParseTreeListener) {mut listener_t,ok:=listener_10 
if ok {
listener_t.enter_filter_statement(s ,)
}
}

pub fn (mut s ParseContext) exit_rule_5(listener_11 antlr.ParseTreeListener) {mut listener_t,ok:=listener_11 
if ok {
listener_t.exit_filter_statement(s ,)
}
}

pub fn (mut p FilterExpressionSyntaxParser) filter_statement_1() (IFilterStatementContext, ) {mut localctx_5:=IFilterStatementContext{}
localctx_5=new_filter_statement_context(p ,p.get_parser_rule_context() ,p.get_state() ,)  
p.enter_rule(localctx_5 ,10 ,filter_expression_syntax_parser_rulefilter_statement ,)
mut _la:=0 
defer {p.exit_rule()
}
defer {mut err_2:=recover() 
if err_2  !=  unsafe { nil }  {
mut v_1,ok:=err_2 
if ok {
localctx_5.set_exception(v_1 ,)
p.get_error_handler.report_error(p ,v_1 ,)
p.get_error_handler.recover(p ,v_1 ,)
}else {
panic(err_2 ,)
}
}
}
p.enter_outer_alt(localctx_5 ,1 ,)
{p.set_state(90 ,)
p.@match(filter_expression_syntax_parser_k_filter ,)
}
p.set_state(93 ,)
p.get_error_handler.sync(p ,)
_la=p.get_token_stream.la(1 ,)  
if _la  ==  filter_expression_syntax_parser_k_top  {
{p.set_state(91 ,)
p.@match(filter_expression_syntax_parser_k_top ,)
}
{p.set_state(92 ,)
p.top_limit()
}
}
{p.set_state(95 ,)
p.table_name()
}
{p.set_state(96 ,)
p.@match(filter_expression_syntax_parser_k_where ,)
}
{p.set_state(97 ,)
p.expression(0 ,)
}
p.set_state(108 ,)
p.get_error_handler.sync(p ,)
_la=p.get_token_stream.la(1 ,)  
if _la  ==  filter_expression_syntax_parser_k_order  {
{p.set_state(98 ,)
p.@match(filter_expression_syntax_parser_k_order ,)
}
{p.set_state(99 ,)
p.@match(filter_expression_syntax_parser_k_by ,)
}
{p.set_state(100 ,)
p.ordering_term()
}
p.set_state(105 ,)
p.get_error_handler.sync(p ,)
_la=p.get_token_stream.la(1 ,)  
for _la  ==  filter_expression_syntax_parser_t_1  {
{p.set_state(101 ,)
p.@match(filter_expression_syntax_parser_t_1 ,)
}
{p.set_state(102 ,)
p.ordering_term()
}
p.set_state(107 ,)
p.get_error_handler.sync(p ,)
_la=p.get_token_stream.la(1 ,)  
}
}
return localctx_5 
}

pub fn new_empty_top_limit_context() (&ParseContext, ) {mut p:=new(ParseContext ,)  
p.base_parser_rule_context=antlr.new_base_parser_rule_context(unsafe { nil } ,- 1  ,)  
p.rule_index=filter_expression_syntax_parser_ruletop_limit  
return p 
}

pub fn (mut _ ParseContext) is_top_limit_context() {}

pub fn new_top_limit_context(parser_6 antlr.Parser, parent_6 antlr.ParserRuleContext, invokingState_6 int) (&ParseContext, ) {mut p:=new(ParseContext ,)  
p.base_parser_rule_context=antlr.new_base_parser_rule_context(parent_6 ,invokingState_6 ,)  
p.parser=parser_6  
p.rule_index=filter_expression_syntax_parser_ruletop_limit  
return p 
}

pub fn (mut s ParseContext) get_parser_6() (antlr.Parser, ) {return s.parser 
}

pub fn (mut s ParseContext) integer_literal() (antlr.TerminalNode, ) {return s.get_token(filter_expression_syntax_parser_integer_literal ,0 ,) 
}

pub fn (mut s ParseContext) get_rule_context_6() (antlr.RuleContext, ) {return s 
}

pub fn (mut s ParseContext) to_string_tree_6(ruleNames_6 []string, recog_6 antlr.Recognizer) (string, ) {return antlr.trees_string_tree(s ,ruleNames_6 ,recog_6 ,) 
}

pub fn (mut s ParseContext) enter_rule_6(listener_12 antlr.ParseTreeListener) {mut listener_t,ok:=listener_12 
if ok {
listener_t.enter_top_limit(s ,)
}
}

pub fn (mut s ParseContext) exit_rule_6(listener_13 antlr.ParseTreeListener) {mut listener_t,ok:=listener_13 
if ok {
listener_t.exit_top_limit(s ,)
}
}

pub fn (mut p FilterExpressionSyntaxParser) top_limit_1() (ITopLimitContext, ) {mut localctx_6:=ITopLimitContext{}
localctx_6=new_top_limit_context(p ,p.get_parser_rule_context() ,p.get_state() ,)  
p.enter_rule(localctx_6 ,12 ,filter_expression_syntax_parser_ruletop_limit ,)
mut _la:=0 
defer {p.exit_rule()
}
defer {mut err_2:=recover() 
if err_2  !=  unsafe { nil }  {
mut v_1,ok:=err_2 
if ok {
localctx_6.set_exception(v_1 ,)
p.get_error_handler.report_error(p ,v_1 ,)
p.get_error_handler.recover(p ,v_1 ,)
}else {
panic(err_2 ,)
}
}
}
p.enter_outer_alt(localctx_6 ,1 ,)
p.set_state(111 ,)
p.get_error_handler.sync(p ,)
_la=p.get_token_stream.la(1 ,)  
if _la  ==  filter_expression_syntax_parser_t_2   ||  _la  ==  filter_expression_syntax_parser_t_3   {
{p.set_state(110 ,)
_la=p.get_token_stream.la(1 ,)  
if ! (_la  ==  filter_expression_syntax_parser_t_2   ||  _la  ==  filter_expression_syntax_parser_t_3   )  {
p.get_error_handler.recover_inline(p ,)
}else {
p.get_error_handler.report_match(p ,)
p.consume()
}
}
}
{p.set_state(113 ,)
p.@match(filter_expression_syntax_parser_integer_literal ,)
}
return localctx_6 
}

pub fn new_empty_ordering_term_context() (&ParseContext, ) {mut p:=new(ParseContext ,)  
p.base_parser_rule_context=antlr.new_base_parser_rule_context(unsafe { nil } ,- 1  ,)  
p.rule_index=filter_expression_syntax_parser_ruleordering_term  
return p 
}

pub fn (mut _ ParseContext) is_ordering_term_context() {}

pub fn new_ordering_term_context(parser_7 antlr.Parser, parent_7 antlr.ParserRuleContext, invokingState_7 int) (&ParseContext, ) {mut p:=new(ParseContext ,)  
p.base_parser_rule_context=antlr.new_base_parser_rule_context(parent_7 ,invokingState_7 ,)  
p.parser=parser_7  
p.rule_index=filter_expression_syntax_parser_ruleordering_term  
return p 
}

pub fn (mut s ParseContext) get_parser_7() (antlr.Parser, ) {return s.parser 
}

pub fn (mut s ParseContext) order_by_column_name() (IOrderByColumnNameContext, ) {mut t:=s.get_typed_rule_context(reflect.type_of.elem() ,0 ,)  
if t  ==  unsafe { nil }  {
return unsafe { nil } 
}
return t 
}

pub fn (mut s ParseContext) exact_match_modifier() (IExactMatchModifierContext, ) {mut t:=s.get_typed_rule_context(reflect.type_of.elem() ,0 ,)  
if t  ==  unsafe { nil }  {
return unsafe { nil } 
}
return t 
}

pub fn (mut s ParseContext) k_asc() (antlr.TerminalNode, ) {return s.get_token(filter_expression_syntax_parser_k_asc ,0 ,) 
}

pub fn (mut s ParseContext) k_desc() (antlr.TerminalNode, ) {return s.get_token(filter_expression_syntax_parser_k_desc ,0 ,) 
}

pub fn (mut s ParseContext) get_rule_context_7() (antlr.RuleContext, ) {return s 
}

pub fn (mut s ParseContext) to_string_tree_7(ruleNames_7 []string, recog_7 antlr.Recognizer) (string, ) {return antlr.trees_string_tree(s ,ruleNames_7 ,recog_7 ,) 
}

pub fn (mut s ParseContext) enter_rule_7(listener_14 antlr.ParseTreeListener) {mut listener_t,ok:=listener_14 
if ok {
listener_t.enter_ordering_term(s ,)
}
}

pub fn (mut s ParseContext) exit_rule_7(listener_15 antlr.ParseTreeListener) {mut listener_t,ok:=listener_15 
if ok {
listener_t.exit_ordering_term(s ,)
}
}

pub fn (mut p FilterExpressionSyntaxParser) ordering_term_1() (IOrderingTermContext, ) {mut localctx_7:=IOrderingTermContext{}
localctx_7=new_ordering_term_context(p ,p.get_parser_rule_context() ,p.get_state() ,)  
p.enter_rule(localctx_7 ,14 ,filter_expression_syntax_parser_ruleordering_term ,)
mut _la:=0 
defer {p.exit_rule()
}
defer {mut err_2:=recover() 
if err_2  !=  unsafe { nil }  {
mut v_1,ok:=err_2 
if ok {
localctx_7.set_exception(v_1 ,)
p.get_error_handler.report_error(p ,v_1 ,)
p.get_error_handler.recover(p ,v_1 ,)
}else {
panic(err_2 ,)
}
}
}
p.enter_outer_alt(localctx_7 ,1 ,)
p.set_state(116 ,)
p.get_error_handler.sync(p ,)
_la=p.get_token_stream.la(1 ,)  
if _la  ==  filter_expression_syntax_parser_t_8   ||  _la  ==  filter_expression_syntax_parser_k_binary   {
{p.set_state(115 ,)
p.exact_match_modifier()
}
}
{p.set_state(118 ,)
p.order_by_column_name()
}
p.set_state(120 ,)
p.get_error_handler.sync(p ,)
_la=p.get_token_stream.la(1 ,)  
if _la  ==  filter_expression_syntax_parser_k_asc   ||  _la  ==  filter_expression_syntax_parser_k_desc   {
{p.set_state(119 ,)
_la=p.get_token_stream.la(1 ,)  
if ! (_la  ==  filter_expression_syntax_parser_k_asc   ||  _la  ==  filter_expression_syntax_parser_k_desc   )  {
p.get_error_handler.recover_inline(p ,)
}else {
p.get_error_handler.report_match(p ,)
p.consume()
}
}
}
return localctx_7 
}

pub fn new_empty_expression_list_context() (&ParseContext, ) {mut p:=new(ParseContext ,)  
p.base_parser_rule_context=antlr.new_base_parser_rule_context(unsafe { nil } ,- 1  ,)  
p.rule_index=filter_expression_syntax_parser_ruleexpression_list  
return p 
}

pub fn (mut _ ParseContext) is_expression_list_context() {}

pub fn new_expression_list_context(parser_8 antlr.Parser, parent_8 antlr.ParserRuleContext, invokingState_8 int) (&ParseContext, ) {mut p:=new(ParseContext ,)  
p.base_parser_rule_context=antlr.new_base_parser_rule_context(parent_8 ,invokingState_8 ,)  
p.parser=parser_8  
p.rule_index=filter_expression_syntax_parser_ruleexpression_list  
return p 
}

pub fn (mut s ParseContext) get_parser_8() (antlr.Parser, ) {return s.parser 
}

pub fn (mut s ParseContext) all_expression() ([]IExpressionContext, ) {mut ts:=s.get_typed_rule_contexts(reflect.type_of.elem() ,)  
mut tst:=[]IExpressionContext{len: ts .len }  
for i_2, t in  ts  {
if t  !=  unsafe { nil }  {
tst[i_2 ]=t  
}
}
return tst 
}

pub fn (mut s ParseContext) expression_2(i_2 int) (IExpressionContext, ) {mut t:=s.get_typed_rule_context(reflect.type_of.elem() ,i_2 ,)  
if t  ==  unsafe { nil }  {
return unsafe { nil } 
}
return t 
}

pub fn (mut s ParseContext) get_rule_context_8() (antlr.RuleContext, ) {return s 
}

pub fn (mut s ParseContext) to_string_tree_8(ruleNames_8 []string, recog_8 antlr.Recognizer) (string, ) {return antlr.trees_string_tree(s ,ruleNames_8 ,recog_8 ,) 
}

pub fn (mut s ParseContext) enter_rule_8(listener_16 antlr.ParseTreeListener) {mut listener_t,ok:=listener_16 
if ok {
listener_t.enter_expression_list(s ,)
}
}

pub fn (mut s ParseContext) exit_rule_8(listener_17 antlr.ParseTreeListener) {mut listener_t,ok:=listener_17 
if ok {
listener_t.exit_expression_list(s ,)
}
}

pub fn (mut p FilterExpressionSyntaxParser) expression_list() (IExpressionListContext, ) {mut localctx_8:=IExpressionListContext{}
localctx_8=new_expression_list_context(p ,p.get_parser_rule_context() ,p.get_state() ,)  
p.enter_rule(localctx_8 ,16 ,filter_expression_syntax_parser_ruleexpression_list ,)
mut _la:=0 
defer {p.exit_rule()
}
defer {mut err_2:=recover() 
if err_2  !=  unsafe { nil }  {
mut v_1,ok:=err_2 
if ok {
localctx_8.set_exception(v_1 ,)
p.get_error_handler.report_error(p ,v_1 ,)
p.get_error_handler.recover(p ,v_1 ,)
}else {
panic(err_2 ,)
}
}
}
p.enter_outer_alt(localctx_8 ,1 ,)
{p.set_state(122 ,)
p.expression(0 ,)
}
p.set_state(127 ,)
p.get_error_handler.sync(p ,)
_la=p.get_token_stream.la(1 ,)  
for _la  ==  filter_expression_syntax_parser_t_1  {
{p.set_state(123 ,)
p.@match(filter_expression_syntax_parser_t_1 ,)
}
{p.set_state(124 ,)
p.expression(0 ,)
}
p.set_state(129 ,)
p.get_error_handler.sync(p ,)
_la=p.get_token_stream.la(1 ,)  
}
return localctx_8 
}

pub fn new_empty_expression_context() (&ParseContext, ) {mut p:=new(ParseContext ,)  
p.base_parser_rule_context=antlr.new_base_parser_rule_context(unsafe { nil } ,- 1  ,)  
p.rule_index=filter_expression_syntax_parser_ruleexpression  
return p 
}

pub fn (mut _ ParseContext) is_expression_context() {}

pub fn new_expression_context(parser_9 antlr.Parser, parent_9 antlr.ParserRuleContext, invokingState_9 int) (&ParseContext, ) {mut p:=new(ParseContext ,)  
p.base_parser_rule_context=antlr.new_base_parser_rule_context(parent_9 ,invokingState_9 ,)  
p.parser=parser_9  
p.rule_index=filter_expression_syntax_parser_ruleexpression  
return p 
}

pub fn (mut s ParseContext) get_parser_9() (antlr.Parser, ) {return s.parser 
}

pub fn (mut s ParseContext) not_operator() (INotOperatorContext, ) {mut t:=s.get_typed_rule_context(reflect.type_of.elem() ,0 ,)  
if t  ==  unsafe { nil }  {
return unsafe { nil } 
}
return t 
}

pub fn (mut s ParseContext) all_expression_1() ([]IExpressionContext, ) {mut ts:=s.get_typed_rule_contexts(reflect.type_of.elem() ,)  
mut tst:=[]IExpressionContext{len: ts .len }  
for i_3, t in  ts  {
if t  !=  unsafe { nil }  {
tst[i_3 ]=t  
}
}
return tst 
}

pub fn (mut s ParseContext) expression_3(i_3 int) (IExpressionContext, ) {mut t:=s.get_typed_rule_context(reflect.type_of.elem() ,i_3 ,)  
if t  ==  unsafe { nil }  {
return unsafe { nil } 
}
return t 
}

pub fn (mut s ParseContext) predicate_expression() (IPredicateExpressionContext, ) {mut t:=s.get_typed_rule_context(reflect.type_of.elem() ,0 ,)  
if t  ==  unsafe { nil }  {
return unsafe { nil } 
}
return t 
}

pub fn (mut s ParseContext) logical_operator() (ILogicalOperatorContext, ) {mut t:=s.get_typed_rule_context(reflect.type_of.elem() ,0 ,)  
if t  ==  unsafe { nil }  {
return unsafe { nil } 
}
return t 
}

pub fn (mut s ParseContext) get_rule_context_9() (antlr.RuleContext, ) {return s 
}

pub fn (mut s ParseContext) to_string_tree_9(ruleNames_9 []string, recog_9 antlr.Recognizer) (string, ) {return antlr.trees_string_tree(s ,ruleNames_9 ,recog_9 ,) 
}

pub fn (mut s ParseContext) enter_rule_9(listener_18 antlr.ParseTreeListener) {mut listener_t,ok:=listener_18 
if ok {
listener_t.enter_expression(s ,)
}
}

pub fn (mut s ParseContext) exit_rule_9(listener_19 antlr.ParseTreeListener) {mut listener_t,ok:=listener_19 
if ok {
listener_t.exit_expression(s ,)
}
}

pub fn (mut p FilterExpressionSyntaxParser) expression_4() (IExpressionContext, ) {mut localctx_9:=IExpressionContext{}
return p.expression(0 ,) 
}

fn (mut p FilterExpressionSyntaxParser) expression_5(_p int) (IExpressionContext, ) {mut localctx_10:=IExpressionContext{}
mut _parentctx:=antlr.ParserRuleContext(p.get_parser_rule_context() ) 
mut _parent_state:=p.get_state()  
localctx_10=new_expression_context(p ,p.get_parser_rule_context() ,_parent_state ,)  
mut _prevctx:=IExpressionContext(localctx_10 ) 
mut _:=antlr.ParserRuleContext(_prevctx ) 
mut _start_state:=18  
p.enter_recursion_rule(localctx_10 ,18 ,filter_expression_syntax_parser_ruleexpression ,_p ,)
defer {p.unroll_recursion_contexts(_parentctx ,)
}
defer {mut err_2:=recover() 
if err_2  !=  unsafe { nil }  {
mut v_1,ok:=err_2 
if ok {
localctx_10.set_exception(v_1 ,)
p.get_error_handler.report_error(p ,v_1 ,)
p.get_error_handler.recover(p ,v_1 ,)
}else {
panic(err_2 ,)
}
}
}
mut _alt:=0 
p.enter_outer_alt(localctx_10 ,1 ,)
p.set_state(135 ,)
p.get_error_handler.sync(p ,)
 match p.get_interpreter.adaptive_predict(p.get_token_stream() ,13 ,p.get_parser_rule_context() ,) {1 {
{p.set_state(131 ,)
p.not_operator()
}
{p.set_state(132 ,)
p.expression(3 ,)
}
}
2 {
{p.set_state(134 ,)
p.predicate_expression(0 ,)
}
}
else{
}
}
p.get_parser_rule_context.set_stop(p.get_token_stream.lt(- 1  ,) ,)
p.set_state(143 ,)
p.get_error_handler.sync(p ,)
_alt=p.get_interpreter.adaptive_predict(p.get_token_stream() ,14 ,p.get_parser_rule_context() ,)  
for _alt  !=  2   &&  _alt  !=  antlr.atninvalid_alt_number   {
if _alt  ==  1  {
if p.get_parse_listeners()  !=  unsafe { nil }  {
p.trigger_exit_rule_event()
}
_prevctx=localctx_10  
localctx_10=new_expression_context(p ,_parentctx ,_parent_state ,)  
p.push_new_recursion_context(localctx_10 ,_start_state ,filter_expression_syntax_parser_ruleexpression ,)
p.set_state(137 ,)
if ! (p.precpred(p.get_parser_rule_context() ,2 ,) )  {
panic(antlr.new_failed_predicate_exception(p ,"p.Precpred(p.GetParserRuleContext(), 2)" ,"" ,) ,)
}
{p.set_state(138 ,)
p.logical_operator()
}
{p.set_state(139 ,)
p.expression(3 ,)
}
}
p.set_state(145 ,)
p.get_error_handler.sync(p ,)
_alt=p.get_interpreter.adaptive_predict(p.get_token_stream() ,14 ,p.get_parser_rule_context() ,)  
}
return localctx_10 
}

pub fn new_empty_predicate_expression_context() (&ParseContext, ) {mut p:=new(ParseContext ,)  
p.base_parser_rule_context=antlr.new_base_parser_rule_context(unsafe { nil } ,- 1  ,)  
p.rule_index=filter_expression_syntax_parser_rulepredicate_expression  
return p 
}

pub fn (mut _ ParseContext) is_predicate_expression_context() {}

pub fn new_predicate_expression_context(parser_10 antlr.Parser, parent_10 antlr.ParserRuleContext, invokingState_10 int) (&ParseContext, ) {mut p:=new(ParseContext ,)  
p.base_parser_rule_context=antlr.new_base_parser_rule_context(parent_10 ,invokingState_10 ,)  
p.parser=parser_10  
p.rule_index=filter_expression_syntax_parser_rulepredicate_expression  
return p 
}

pub fn (mut s ParseContext) get_parser_10() (antlr.Parser, ) {return s.parser 
}

pub fn (mut s ParseContext) value_expression() (IValueExpressionContext, ) {mut t:=s.get_typed_rule_context(reflect.type_of.elem() ,0 ,)  
if t  ==  unsafe { nil }  {
return unsafe { nil } 
}
return t 
}

pub fn (mut s ParseContext) all_predicate_expression() ([]IPredicateExpressionContext, ) {mut ts:=s.get_typed_rule_contexts(reflect.type_of.elem() ,)  
mut tst:=[]IPredicateExpressionContext{len: ts .len }  
for i_4, t in  ts  {
if t  !=  unsafe { nil }  {
tst[i_4 ]=t  
}
}
return tst 
}

pub fn (mut s ParseContext) predicate_expression_1(i_4 int) (IPredicateExpressionContext, ) {mut t:=s.get_typed_rule_context(reflect.type_of.elem() ,i_4 ,)  
if t  ==  unsafe { nil }  {
return unsafe { nil } 
}
return t 
}

pub fn (mut s ParseContext) comparison_operator() (IComparisonOperatorContext, ) {mut t:=s.get_typed_rule_context(reflect.type_of.elem() ,0 ,)  
if t  ==  unsafe { nil }  {
return unsafe { nil } 
}
return t 
}

pub fn (mut s ParseContext) k_like() (antlr.TerminalNode, ) {return s.get_token(filter_expression_syntax_parser_k_like ,0 ,) 
}

pub fn (mut s ParseContext) not_operator_1() (INotOperatorContext, ) {mut t:=s.get_typed_rule_context(reflect.type_of.elem() ,0 ,)  
if t  ==  unsafe { nil }  {
return unsafe { nil } 
}
return t 
}

pub fn (mut s ParseContext) exact_match_modifier_1() (IExactMatchModifierContext, ) {mut t:=s.get_typed_rule_context(reflect.type_of.elem() ,0 ,)  
if t  ==  unsafe { nil }  {
return unsafe { nil } 
}
return t 
}

pub fn (mut s ParseContext) k_in() (antlr.TerminalNode, ) {return s.get_token(filter_expression_syntax_parser_k_in ,0 ,) 
}

pub fn (mut s ParseContext) expression_list_1() (IExpressionListContext, ) {mut t:=s.get_typed_rule_context(reflect.type_of.elem() ,0 ,)  
if t  ==  unsafe { nil }  {
return unsafe { nil } 
}
return t 
}

pub fn (mut s ParseContext) k_is() (antlr.TerminalNode, ) {return s.get_token(filter_expression_syntax_parser_k_is ,0 ,) 
}

pub fn (mut s ParseContext) k_null() (antlr.TerminalNode, ) {return s.get_token(filter_expression_syntax_parser_k_null ,0 ,) 
}

pub fn (mut s ParseContext) get_rule_context_10() (antlr.RuleContext, ) {return s 
}

pub fn (mut s ParseContext) to_string_tree_10(ruleNames_10 []string, recog_10 antlr.Recognizer) (string, ) {return antlr.trees_string_tree(s ,ruleNames_10 ,recog_10 ,) 
}

pub fn (mut s ParseContext) enter_rule_10(listener_20 antlr.ParseTreeListener) {mut listener_t,ok:=listener_20 
if ok {
listener_t.enter_predicate_expression(s ,)
}
}

pub fn (mut s ParseContext) exit_rule_10(listener_21 antlr.ParseTreeListener) {mut listener_t,ok:=listener_21 
if ok {
listener_t.exit_predicate_expression(s ,)
}
}

pub fn (mut p FilterExpressionSyntaxParser) predicate_expression_2() (IPredicateExpressionContext, ) {mut localctx_11:=IPredicateExpressionContext{}
return p.predicate_expression(0 ,) 
}

//gocyclo:ig
fn (mut p FilterExpressionSyntaxParser) predicate_expression_3(_p_1 int) (IPredicateExpressionContext, ) {mut localctx_12:=IPredicateExpressionContext{}
mut _parentctx:=antlr.ParserRuleContext(p.get_parser_rule_context() ) 
mut _parent_state:=p.get_state()  
localctx_12=new_predicate_expression_context(p ,p.get_parser_rule_context() ,_parent_state ,)  
mut _prevctx:=IPredicateExpressionContext(localctx_12 ) 
mut _:=antlr.ParserRuleContext(_prevctx ) 
mut _start_state:=20  
p.enter_recursion_rule(localctx_12 ,20 ,filter_expression_syntax_parser_rulepredicate_expression ,_p_1 ,)
mut _la:=0 
defer {p.unroll_recursion_contexts(_parentctx ,)
}
defer {mut err_2:=recover() 
if err_2  !=  unsafe { nil }  {
mut v_1,ok:=err_2 
if ok {
localctx_12.set_exception(v_1 ,)
p.get_error_handler.report_error(p ,v_1 ,)
p.get_error_handler.recover(p ,v_1 ,)
}else {
panic(err_2 ,)
}
}
}
mut _alt:=0 
p.enter_outer_alt(localctx_12 ,1 ,)
{p.set_state(147 ,)
p.value_expression(0 ,)
}
p.get_parser_rule_context.set_stop(p.get_token_stream.lt(- 1  ,) ,)
p.set_state(182 ,)
p.get_error_handler.sync(p ,)
_alt=p.get_interpreter.adaptive_predict(p.get_token_stream() ,21 ,p.get_parser_rule_context() ,)  
for _alt  !=  2   &&  _alt  !=  antlr.atninvalid_alt_number   {
if _alt  ==  1  {
if p.get_parse_listeners()  !=  unsafe { nil }  {
p.trigger_exit_rule_event()
}
_prevctx=localctx_12  
p.set_state(180 ,)
p.get_error_handler.sync(p ,)
 match p.get_interpreter.adaptive_predict(p.get_token_stream() ,20 ,p.get_parser_rule_context() ,) {1 {
localctx_12=new_predicate_expression_context(p ,_parentctx ,_parent_state ,)  
p.push_new_recursion_context(localctx_12 ,_start_state ,filter_expression_syntax_parser_rulepredicate_expression ,)
p.set_state(149 ,)
if ! (p.precpred(p.get_parser_rule_context() ,3 ,) )  {
panic(antlr.new_failed_predicate_exception(p ,"p.Precpred(p.GetParserRuleContext(), 3)" ,"" ,) ,)
}
{p.set_state(150 ,)
p.comparison_operator()
}
{p.set_state(151 ,)
p.predicate_expression(4 ,)
}
}
2 {
localctx_12=new_predicate_expression_context(p ,_parentctx ,_parent_state ,)  
p.push_new_recursion_context(localctx_12 ,_start_state ,filter_expression_syntax_parser_rulepredicate_expression ,)
p.set_state(153 ,)
if ! (p.precpred(p.get_parser_rule_context() ,2 ,) )  {
panic(antlr.new_failed_predicate_exception(p ,"p.Precpred(p.GetParserRuleContext(), 2)" ,"" ,) ,)
}
p.set_state(155 ,)
p.get_error_handler.sync(p ,)
_la=p.get_token_stream.la(1 ,)  
if _la  ==  filter_expression_syntax_parser_t_6   ||  _la  ==  filter_expression_syntax_parser_k_not   {
{p.set_state(154 ,)
p.not_operator()
}
}
{p.set_state(157 ,)
p.@match(filter_expression_syntax_parser_k_like ,)
}
p.set_state(159 ,)
p.get_error_handler.sync(p ,)
_la=p.get_token_stream.la(1 ,)  
if _la  ==  filter_expression_syntax_parser_t_8   ||  _la  ==  filter_expression_syntax_parser_k_binary   {
{p.set_state(158 ,)
p.exact_match_modifier()
}
}
{p.set_state(161 ,)
p.predicate_expression(3 ,)
}
}
3 {
localctx_12=new_predicate_expression_context(p ,_parentctx ,_parent_state ,)  
p.push_new_recursion_context(localctx_12 ,_start_state ,filter_expression_syntax_parser_rulepredicate_expression ,)
p.set_state(162 ,)
if ! (p.precpred(p.get_parser_rule_context() ,5 ,) )  {
panic(antlr.new_failed_predicate_exception(p ,"p.Precpred(p.GetParserRuleContext(), 5)" ,"" ,) ,)
}
p.set_state(164 ,)
p.get_error_handler.sync(p ,)
_la=p.get_token_stream.la(1 ,)  
if _la  ==  filter_expression_syntax_parser_t_6   ||  _la  ==  filter_expression_syntax_parser_k_not   {
{p.set_state(163 ,)
p.not_operator()
}
}
{p.set_state(166 ,)
p.@match(filter_expression_syntax_parser_k_in ,)
}
p.set_state(168 ,)
p.get_error_handler.sync(p ,)
_la=p.get_token_stream.la(1 ,)  
if _la  ==  filter_expression_syntax_parser_t_8   ||  _la  ==  filter_expression_syntax_parser_k_binary   {
{p.set_state(167 ,)
p.exact_match_modifier()
}
}
{p.set_state(170 ,)
p.@match(filter_expression_syntax_parser_t_4 ,)
}
{p.set_state(171 ,)
p.expression_list()
}
{p.set_state(172 ,)
p.@match(filter_expression_syntax_parser_t_5 ,)
}
}
4 {
localctx_12=new_predicate_expression_context(p ,_parentctx ,_parent_state ,)  
p.push_new_recursion_context(localctx_12 ,_start_state ,filter_expression_syntax_parser_rulepredicate_expression ,)
p.set_state(174 ,)
if ! (p.precpred(p.get_parser_rule_context() ,4 ,) )  {
panic(antlr.new_failed_predicate_exception(p ,"p.Precpred(p.GetParserRuleContext(), 4)" ,"" ,) ,)
}
{p.set_state(175 ,)
p.@match(filter_expression_syntax_parser_k_is ,)
}
p.set_state(177 ,)
p.get_error_handler.sync(p ,)
_la=p.get_token_stream.la(1 ,)  
if _la  ==  filter_expression_syntax_parser_t_6   ||  _la  ==  filter_expression_syntax_parser_k_not   {
{p.set_state(176 ,)
p.not_operator()
}
}
{p.set_state(179 ,)
p.@match(filter_expression_syntax_parser_k_null ,)
}
}
else{
}
}
}
p.set_state(184 ,)
p.get_error_handler.sync(p ,)
_alt=p.get_interpreter.adaptive_predict(p.get_token_stream() ,21 ,p.get_parser_rule_context() ,)  
}
return localctx_12 
}

pub fn new_empty_value_expression_context() (&ParseContext, ) {mut p:=new(ParseContext ,)  
p.base_parser_rule_context=antlr.new_base_parser_rule_context(unsafe { nil } ,- 1  ,)  
p.rule_index=filter_expression_syntax_parser_rulevalue_expression  
return p 
}

pub fn (mut _ ParseContext) is_value_expression_context() {}

pub fn new_value_expression_context(parser_11 antlr.Parser, parent_11 antlr.ParserRuleContext, invokingState_11 int) (&ParseContext, ) {mut p:=new(ParseContext ,)  
p.base_parser_rule_context=antlr.new_base_parser_rule_context(parent_11 ,invokingState_11 ,)  
p.parser=parser_11  
p.rule_index=filter_expression_syntax_parser_rulevalue_expression  
return p 
}

pub fn (mut s ParseContext) get_parser_11() (antlr.Parser, ) {return s.parser 
}

pub fn (mut s ParseContext) literal_value() (ILiteralValueContext, ) {mut t:=s.get_typed_rule_context(reflect.type_of.elem() ,0 ,)  
if t  ==  unsafe { nil }  {
return unsafe { nil } 
}
return t 
}

pub fn (mut s ParseContext) column_name() (IColumnNameContext, ) {mut t:=s.get_typed_rule_context(reflect.type_of.elem() ,0 ,)  
if t  ==  unsafe { nil }  {
return unsafe { nil } 
}
return t 
}

pub fn (mut s ParseContext) function_expression() (IFunctionExpressionContext, ) {mut t:=s.get_typed_rule_context(reflect.type_of.elem() ,0 ,)  
if t  ==  unsafe { nil }  {
return unsafe { nil } 
}
return t 
}

pub fn (mut s ParseContext) unary_operator() (IUnaryOperatorContext, ) {mut t:=s.get_typed_rule_context(reflect.type_of.elem() ,0 ,)  
if t  ==  unsafe { nil }  {
return unsafe { nil } 
}
return t 
}

pub fn (mut s ParseContext) all_value_expression() ([]IValueExpressionContext, ) {mut ts:=s.get_typed_rule_contexts(reflect.type_of.elem() ,)  
mut tst:=[]IValueExpressionContext{len: ts .len }  
for i_5, t in  ts  {
if t  !=  unsafe { nil }  {
tst[i_5 ]=t  
}
}
return tst 
}

pub fn (mut s ParseContext) value_expression_1(i_5 int) (IValueExpressionContext, ) {mut t:=s.get_typed_rule_context(reflect.type_of.elem() ,i_5 ,)  
if t  ==  unsafe { nil }  {
return unsafe { nil } 
}
return t 
}

pub fn (mut s ParseContext) expression_6() (IExpressionContext, ) {mut t:=s.get_typed_rule_context(reflect.type_of.elem() ,0 ,)  
if t  ==  unsafe { nil }  {
return unsafe { nil } 
}
return t 
}

pub fn (mut s ParseContext) math_operator() (IMathOperatorContext, ) {mut t:=s.get_typed_rule_context(reflect.type_of.elem() ,0 ,)  
if t  ==  unsafe { nil }  {
return unsafe { nil } 
}
return t 
}

pub fn (mut s ParseContext) bitwise_operator() (IBitwiseOperatorContext, ) {mut t:=s.get_typed_rule_context(reflect.type_of.elem() ,0 ,)  
if t  ==  unsafe { nil }  {
return unsafe { nil } 
}
return t 
}

pub fn (mut s ParseContext) get_rule_context_11() (antlr.RuleContext, ) {return s 
}

pub fn (mut s ParseContext) to_string_tree_11(ruleNames_11 []string, recog_11 antlr.Recognizer) (string, ) {return antlr.trees_string_tree(s ,ruleNames_11 ,recog_11 ,) 
}

pub fn (mut s ParseContext) enter_rule_11(listener_22 antlr.ParseTreeListener) {mut listener_t,ok:=listener_22 
if ok {
listener_t.enter_value_expression(s ,)
}
}

pub fn (mut s ParseContext) exit_rule_11(listener_23 antlr.ParseTreeListener) {mut listener_t,ok:=listener_23 
if ok {
listener_t.exit_value_expression(s ,)
}
}

pub fn (mut p FilterExpressionSyntaxParser) value_expression_2() (IValueExpressionContext, ) {mut localctx_13:=IValueExpressionContext{}
return p.value_expression(0 ,) 
}

//gocyclo:ig
fn (mut p FilterExpressionSyntaxParser) value_expression_3(_p_2 int) (IValueExpressionContext, ) {mut localctx_14:=IValueExpressionContext{}
mut _parentctx:=antlr.ParserRuleContext(p.get_parser_rule_context() ) 
mut _parent_state:=p.get_state()  
localctx_14=new_value_expression_context(p ,p.get_parser_rule_context() ,_parent_state ,)  
mut _prevctx:=IValueExpressionContext(localctx_14 ) 
mut _:=antlr.ParserRuleContext(_prevctx ) 
mut _start_state:=22  
p.enter_recursion_rule(localctx_14 ,22 ,filter_expression_syntax_parser_rulevalue_expression ,_p_2 ,)
defer {p.unroll_recursion_contexts(_parentctx ,)
}
defer {mut err_2:=recover() 
if err_2  !=  unsafe { nil }  {
mut v_1,ok:=err_2 
if ok {
localctx_14.set_exception(v_1 ,)
p.get_error_handler.report_error(p ,v_1 ,)
p.get_error_handler.recover(p ,v_1 ,)
}else {
panic(err_2 ,)
}
}
}
mut _alt:=0 
p.enter_outer_alt(localctx_14 ,1 ,)
p.set_state(196 ,)
p.get_error_handler.sync(p ,)
 match p.get_token_stream.la(1 ,) {filter_expression_syntax_parser_k_null ,filter_expression_syntax_parser_boolean_literal ,filter_expression_syntax_parser_integer_literal ,filter_expression_syntax_parser_numeric_literal ,filter_expression_syntax_parser_guid_literal ,filter_expression_syntax_parser_string_literal ,filter_expression_syntax_parser_datetime_literal {
{p.set_state(186 ,)
p.literal_value()
}
}
filter_expression_syntax_parser_identifier {
{p.set_state(187 ,)
p.column_name()
}
}
filter_expression_syntax_parser_k_abs ,filter_expression_syntax_parser_k_ceiling ,filter_expression_syntax_parser_k_coalesce ,filter_expression_syntax_parser_k_convert ,filter_expression_syntax_parser_k_contains ,filter_expression_syntax_parser_k_dateadd ,filter_expression_syntax_parser_k_datediff ,filter_expression_syntax_parser_k_datepart ,filter_expression_syntax_parser_k_endswith ,filter_expression_syntax_parser_k_floor ,filter_expression_syntax_parser_k_iif ,filter_expression_syntax_parser_k_indexof ,filter_expression_syntax_parser_k_isdate ,filter_expression_syntax_parser_k_isinteger ,filter_expression_syntax_parser_k_isguid ,filter_expression_syntax_parser_k_isnull ,filter_expression_syntax_parser_k_isnumeric ,filter_expression_syntax_parser_k_lastindexof ,filter_expression_syntax_parser_k_len ,filter_expression_syntax_parser_k_lower ,filter_expression_syntax_parser_k_maxof ,filter_expression_syntax_parser_k_minof ,filter_expression_syntax_parser_k_now ,filter_expression_syntax_parser_k_nthindexof ,filter_expression_syntax_parser_k_power ,filter_expression_syntax_parser_k_regexmatch ,filter_expression_syntax_parser_k_regexval ,filter_expression_syntax_parser_k_replace ,filter_expression_syntax_parser_k_reverse ,filter_expression_syntax_parser_k_round ,filter_expression_syntax_parser_k_sqrt ,filter_expression_syntax_parser_k_split ,filter_expression_syntax_parser_k_startswith ,filter_expression_syntax_parser_k_strcount ,filter_expression_syntax_parser_k_strcmp ,filter_expression_syntax_parser_k_substr ,filter_expression_syntax_parser_k_trim ,filter_expression_syntax_parser_k_trimleft ,filter_expression_syntax_parser_k_trimright ,filter_expression_syntax_parser_k_upper ,filter_expression_syntax_parser_k_utcnow {
{p.set_state(188 ,)
p.function_expression()
}
}
filter_expression_syntax_parser_t_2 ,filter_expression_syntax_parser_t_3 ,filter_expression_syntax_parser_t_6 ,filter_expression_syntax_parser_t_7 ,filter_expression_syntax_parser_k_not {
{p.set_state(189 ,)
p.unary_operator()
}
{p.set_state(190 ,)
p.value_expression(4 ,)
}
}
filter_expression_syntax_parser_t_4 {
{p.set_state(192 ,)
p.@match(filter_expression_syntax_parser_t_4 ,)
}
{p.set_state(193 ,)
p.expression(0 ,)
}
{p.set_state(194 ,)
p.@match(filter_expression_syntax_parser_t_5 ,)
}
}
else{
panic(antlr.new_no_viable_alt_exception(p ,unsafe { nil } ,unsafe { nil } ,unsafe { nil } ,unsafe { nil } ,unsafe { nil } ,) ,)
}
}
p.get_parser_rule_context.set_stop(p.get_token_stream.lt(- 1  ,) ,)
p.set_state(208 ,)
p.get_error_handler.sync(p ,)
_alt=p.get_interpreter.adaptive_predict(p.get_token_stream() ,24 ,p.get_parser_rule_context() ,)  
for _alt  !=  2   &&  _alt  !=  antlr.atninvalid_alt_number   {
if _alt  ==  1  {
if p.get_parse_listeners()  !=  unsafe { nil }  {
p.trigger_exit_rule_event()
}
_prevctx=localctx_14  
p.set_state(206 ,)
p.get_error_handler.sync(p ,)
 match p.get_interpreter.adaptive_predict(p.get_token_stream() ,23 ,p.get_parser_rule_context() ,) {1 {
localctx_14=new_value_expression_context(p ,_parentctx ,_parent_state ,)  
p.push_new_recursion_context(localctx_14 ,_start_state ,filter_expression_syntax_parser_rulevalue_expression ,)
p.set_state(198 ,)
if ! (p.precpred(p.get_parser_rule_context() ,2 ,) )  {
panic(antlr.new_failed_predicate_exception(p ,"p.Precpred(p.GetParserRuleContext(), 2)" ,"" ,) ,)
}
{p.set_state(199 ,)
p.math_operator()
}
{p.set_state(200 ,)
p.value_expression(3 ,)
}
}
2 {
localctx_14=new_value_expression_context(p ,_parentctx ,_parent_state ,)  
p.push_new_recursion_context(localctx_14 ,_start_state ,filter_expression_syntax_parser_rulevalue_expression ,)
p.set_state(202 ,)
if ! (p.precpred(p.get_parser_rule_context() ,1 ,) )  {
panic(antlr.new_failed_predicate_exception(p ,"p.Precpred(p.GetParserRuleContext(), 1)" ,"" ,) ,)
}
{p.set_state(203 ,)
p.bitwise_operator()
}
{p.set_state(204 ,)
p.value_expression(2 ,)
}
}
else{
}
}
}
p.set_state(210 ,)
p.get_error_handler.sync(p ,)
_alt=p.get_interpreter.adaptive_predict(p.get_token_stream() ,24 ,p.get_parser_rule_context() ,)  
}
return localctx_14 
}

pub fn new_empty_not_operator_context() (&ParseContext, ) {mut p:=new(ParseContext ,)  
p.base_parser_rule_context=antlr.new_base_parser_rule_context(unsafe { nil } ,- 1  ,)  
p.rule_index=filter_expression_syntax_parser_rulenot_operator  
return p 
}

pub fn (mut _ ParseContext) is_not_operator_context() {}

pub fn new_not_operator_context(parser_12 antlr.Parser, parent_12 antlr.ParserRuleContext, invokingState_12 int) (&ParseContext, ) {mut p:=new(ParseContext ,)  
p.base_parser_rule_context=antlr.new_base_parser_rule_context(parent_12 ,invokingState_12 ,)  
p.parser=parser_12  
p.rule_index=filter_expression_syntax_parser_rulenot_operator  
return p 
}

pub fn (mut s ParseContext) get_parser_12() (antlr.Parser, ) {return s.parser 
}

pub fn (mut s ParseContext) k_not() (antlr.TerminalNode, ) {return s.get_token(filter_expression_syntax_parser_k_not ,0 ,) 
}

pub fn (mut s ParseContext) get_rule_context_12() (antlr.RuleContext, ) {return s 
}

pub fn (mut s ParseContext) to_string_tree_12(ruleNames_12 []string, recog_12 antlr.Recognizer) (string, ) {return antlr.trees_string_tree(s ,ruleNames_12 ,recog_12 ,) 
}

pub fn (mut s ParseContext) enter_rule_12(listener_24 antlr.ParseTreeListener) {mut listener_t,ok:=listener_24 
if ok {
listener_t.enter_not_operator(s ,)
}
}

pub fn (mut s ParseContext) exit_rule_12(listener_25 antlr.ParseTreeListener) {mut listener_t,ok:=listener_25 
if ok {
listener_t.exit_not_operator(s ,)
}
}

pub fn (mut p FilterExpressionSyntaxParser) not_operator_2() (INotOperatorContext, ) {mut localctx_15:=INotOperatorContext{}
localctx_15=new_not_operator_context(p ,p.get_parser_rule_context() ,p.get_state() ,)  
p.enter_rule(localctx_15 ,24 ,filter_expression_syntax_parser_rulenot_operator ,)
mut _la:=0 
defer {p.exit_rule()
}
defer {mut err_2:=recover() 
if err_2  !=  unsafe { nil }  {
mut v_1,ok:=err_2 
if ok {
localctx_15.set_exception(v_1 ,)
p.get_error_handler.report_error(p ,v_1 ,)
p.get_error_handler.recover(p ,v_1 ,)
}else {
panic(err_2 ,)
}
}
}
p.enter_outer_alt(localctx_15 ,1 ,)
{p.set_state(211 ,)
_la=p.get_token_stream.la(1 ,)  
if ! (_la  ==  filter_expression_syntax_parser_t_6   ||  _la  ==  filter_expression_syntax_parser_k_not   )  {
p.get_error_handler.recover_inline(p ,)
}else {
p.get_error_handler.report_match(p ,)
p.consume()
}
}
return localctx_15 
}

pub fn new_empty_unary_operator_context() (&ParseContext, ) {mut p:=new(ParseContext ,)  
p.base_parser_rule_context=antlr.new_base_parser_rule_context(unsafe { nil } ,- 1  ,)  
p.rule_index=filter_expression_syntax_parser_ruleunary_operator  
return p 
}

pub fn (mut _ ParseContext) is_unary_operator_context() {}

pub fn new_unary_operator_context(parser_13 antlr.Parser, parent_13 antlr.ParserRuleContext, invokingState_13 int) (&ParseContext, ) {mut p:=new(ParseContext ,)  
p.base_parser_rule_context=antlr.new_base_parser_rule_context(parent_13 ,invokingState_13 ,)  
p.parser=parser_13  
p.rule_index=filter_expression_syntax_parser_ruleunary_operator  
return p 
}

pub fn (mut s ParseContext) get_parser_13() (antlr.Parser, ) {return s.parser 
}

pub fn (mut s ParseContext) k_not_1() (antlr.TerminalNode, ) {return s.get_token(filter_expression_syntax_parser_k_not ,0 ,) 
}

pub fn (mut s ParseContext) get_rule_context_13() (antlr.RuleContext, ) {return s 
}

pub fn (mut s ParseContext) to_string_tree_13(ruleNames_13 []string, recog_13 antlr.Recognizer) (string, ) {return antlr.trees_string_tree(s ,ruleNames_13 ,recog_13 ,) 
}

pub fn (mut s ParseContext) enter_rule_13(listener_26 antlr.ParseTreeListener) {mut listener_t,ok:=listener_26 
if ok {
listener_t.enter_unary_operator(s ,)
}
}

pub fn (mut s ParseContext) exit_rule_13(listener_27 antlr.ParseTreeListener) {mut listener_t,ok:=listener_27 
if ok {
listener_t.exit_unary_operator(s ,)
}
}

pub fn (mut p FilterExpressionSyntaxParser) unary_operator_1() (IUnaryOperatorContext, ) {mut localctx_16:=IUnaryOperatorContext{}
localctx_16=new_unary_operator_context(p ,p.get_parser_rule_context() ,p.get_state() ,)  
p.enter_rule(localctx_16 ,26 ,filter_expression_syntax_parser_ruleunary_operator ,)
mut _la:=0 
defer {p.exit_rule()
}
defer {mut err_2:=recover() 
if err_2  !=  unsafe { nil }  {
mut v_1,ok:=err_2 
if ok {
localctx_16.set_exception(v_1 ,)
p.get_error_handler.report_error(p ,v_1 ,)
p.get_error_handler.recover(p ,v_1 ,)
}else {
panic(err_2 ,)
}
}
}
p.enter_outer_alt(localctx_16 ,1 ,)
{p.set_state(213 ,)
_la=p.get_token_stream.la(1 ,)  
if ! ((((_la )  &  - (0x1f  +  1  )   )  ==  0   &&  ((1  <<  uint(_la ,)  )  &  ((1  <<  filter_expression_syntax_parser_t_2  )  |  (1  <<  filter_expression_syntax_parser_t_3  )   |  (1  <<  filter_expression_syntax_parser_t_6  )   |  (1  <<  filter_expression_syntax_parser_t_7  )  )  )  !=  0   )  ||  _la  ==  filter_expression_syntax_parser_k_not   )  {
p.get_error_handler.recover_inline(p ,)
}else {
p.get_error_handler.report_match(p ,)
p.consume()
}
}
return localctx_16 
}

pub fn new_empty_exact_match_modifier_context() (&ParseContext, ) {mut p:=new(ParseContext ,)  
p.base_parser_rule_context=antlr.new_base_parser_rule_context(unsafe { nil } ,- 1  ,)  
p.rule_index=filter_expression_syntax_parser_ruleexact_match_modifier  
return p 
}

pub fn (mut _ ParseContext) is_exact_match_modifier_context() {}

pub fn new_exact_match_modifier_context(parser_14 antlr.Parser, parent_14 antlr.ParserRuleContext, invokingState_14 int) (&ParseContext, ) {mut p:=new(ParseContext ,)  
p.base_parser_rule_context=antlr.new_base_parser_rule_context(parent_14 ,invokingState_14 ,)  
p.parser=parser_14  
p.rule_index=filter_expression_syntax_parser_ruleexact_match_modifier  
return p 
}

pub fn (mut s ParseContext) get_parser_14() (antlr.Parser, ) {return s.parser 
}

pub fn (mut s ParseContext) k_binary() (antlr.TerminalNode, ) {return s.get_token(filter_expression_syntax_parser_k_binary ,0 ,) 
}

pub fn (mut s ParseContext) get_rule_context_14() (antlr.RuleContext, ) {return s 
}

pub fn (mut s ParseContext) to_string_tree_14(ruleNames_14 []string, recog_14 antlr.Recognizer) (string, ) {return antlr.trees_string_tree(s ,ruleNames_14 ,recog_14 ,) 
}

pub fn (mut s ParseContext) enter_rule_14(listener_28 antlr.ParseTreeListener) {mut listener_t,ok:=listener_28 
if ok {
listener_t.enter_exact_match_modifier(s ,)
}
}

pub fn (mut s ParseContext) exit_rule_14(listener_29 antlr.ParseTreeListener) {mut listener_t,ok:=listener_29 
if ok {
listener_t.exit_exact_match_modifier(s ,)
}
}

pub fn (mut p FilterExpressionSyntaxParser) exact_match_modifier_2() (IExactMatchModifierContext, ) {mut localctx_17:=IExactMatchModifierContext{}
localctx_17=new_exact_match_modifier_context(p ,p.get_parser_rule_context() ,p.get_state() ,)  
p.enter_rule(localctx_17 ,28 ,filter_expression_syntax_parser_ruleexact_match_modifier ,)
mut _la:=0 
defer {p.exit_rule()
}
defer {mut err_2:=recover() 
if err_2  !=  unsafe { nil }  {
mut v_1,ok:=err_2 
if ok {
localctx_17.set_exception(v_1 ,)
p.get_error_handler.report_error(p ,v_1 ,)
p.get_error_handler.recover(p ,v_1 ,)
}else {
panic(err_2 ,)
}
}
}
p.enter_outer_alt(localctx_17 ,1 ,)
{p.set_state(215 ,)
_la=p.get_token_stream.la(1 ,)  
if ! (_la  ==  filter_expression_syntax_parser_t_8   ||  _la  ==  filter_expression_syntax_parser_k_binary   )  {
p.get_error_handler.recover_inline(p ,)
}else {
p.get_error_handler.report_match(p ,)
p.consume()
}
}
return localctx_17 
}

pub fn new_empty_comparison_operator_context() (&ParseContext, ) {mut p:=new(ParseContext ,)  
p.base_parser_rule_context=antlr.new_base_parser_rule_context(unsafe { nil } ,- 1  ,)  
p.rule_index=filter_expression_syntax_parser_rulecomparison_operator  
return p 
}

pub fn (mut _ ParseContext) is_comparison_operator_context() {}

pub fn new_comparison_operator_context(parser_15 antlr.Parser, parent_15 antlr.ParserRuleContext, invokingState_15 int) (&ParseContext, ) {mut p:=new(ParseContext ,)  
p.base_parser_rule_context=antlr.new_base_parser_rule_context(parent_15 ,invokingState_15 ,)  
p.parser=parser_15  
p.rule_index=filter_expression_syntax_parser_rulecomparison_operator  
return p 
}

pub fn (mut s ParseContext) get_parser_15() (antlr.Parser, ) {return s.parser 
}

pub fn (mut s ParseContext) get_rule_context_15() (antlr.RuleContext, ) {return s 
}

pub fn (mut s ParseContext) to_string_tree_15(ruleNames_15 []string, recog_15 antlr.Recognizer) (string, ) {return antlr.trees_string_tree(s ,ruleNames_15 ,recog_15 ,) 
}

pub fn (mut s ParseContext) enter_rule_15(listener_30 antlr.ParseTreeListener) {mut listener_t,ok:=listener_30 
if ok {
listener_t.enter_comparison_operator(s ,)
}
}

pub fn (mut s ParseContext) exit_rule_15(listener_31 antlr.ParseTreeListener) {mut listener_t,ok:=listener_31 
if ok {
listener_t.exit_comparison_operator(s ,)
}
}

pub fn (mut p FilterExpressionSyntaxParser) comparison_operator_1() (IComparisonOperatorContext, ) {mut localctx_18:=IComparisonOperatorContext{}
localctx_18=new_comparison_operator_context(p ,p.get_parser_rule_context() ,p.get_state() ,)  
p.enter_rule(localctx_18 ,30 ,filter_expression_syntax_parser_rulecomparison_operator ,)
mut _la:=0 
defer {p.exit_rule()
}
defer {mut err_2:=recover() 
if err_2  !=  unsafe { nil }  {
mut v_1,ok:=err_2 
if ok {
localctx_18.set_exception(v_1 ,)
p.get_error_handler.report_error(p ,v_1 ,)
p.get_error_handler.recover(p ,v_1 ,)
}else {
panic(err_2 ,)
}
}
}
p.enter_outer_alt(localctx_18 ,1 ,)
{p.set_state(217 ,)
_la=p.get_token_stream.la(1 ,)  
if ! (((_la )  &  - (0x1f  +  1  )   )  ==  0   &&  ((1  <<  uint(_la ,)  )  &  ((1  <<  filter_expression_syntax_parser_t_8  )  |  (1  <<  filter_expression_syntax_parser_t_9  )   |  (1  <<  filter_expression_syntax_parser_t_10  )   |  (1  <<  filter_expression_syntax_parser_t_11  )   |  (1  <<  filter_expression_syntax_parser_t_12  )   |  (1  <<  filter_expression_syntax_parser_t_13  )   |  (1  <<  filter_expression_syntax_parser_t_14  )   |  (1  <<  filter_expression_syntax_parser_t_15  )   |  (1  <<  filter_expression_syntax_parser_t_16  )   |  (1  <<  filter_expression_syntax_parser_t_17  )  )  )  !=  0   )  {
p.get_error_handler.recover_inline(p ,)
}else {
p.get_error_handler.report_match(p ,)
p.consume()
}
}
return localctx_18 
}

pub fn new_empty_logical_operator_context() (&ParseContext, ) {mut p:=new(ParseContext ,)  
p.base_parser_rule_context=antlr.new_base_parser_rule_context(unsafe { nil } ,- 1  ,)  
p.rule_index=filter_expression_syntax_parser_rulelogical_operator  
return p 
}

pub fn (mut _ ParseContext) is_logical_operator_context() {}

pub fn new_logical_operator_context(parser_16 antlr.Parser, parent_16 antlr.ParserRuleContext, invokingState_16 int) (&ParseContext, ) {mut p:=new(ParseContext ,)  
p.base_parser_rule_context=antlr.new_base_parser_rule_context(parent_16 ,invokingState_16 ,)  
p.parser=parser_16  
p.rule_index=filter_expression_syntax_parser_rulelogical_operator  
return p 
}

pub fn (mut s ParseContext) get_parser_16() (antlr.Parser, ) {return s.parser 
}

pub fn (mut s ParseContext) k_and() (antlr.TerminalNode, ) {return s.get_token(filter_expression_syntax_parser_k_and ,0 ,) 
}

pub fn (mut s ParseContext) k_or() (antlr.TerminalNode, ) {return s.get_token(filter_expression_syntax_parser_k_or ,0 ,) 
}

pub fn (mut s ParseContext) get_rule_context_16() (antlr.RuleContext, ) {return s 
}

pub fn (mut s ParseContext) to_string_tree_16(ruleNames_16 []string, recog_16 antlr.Recognizer) (string, ) {return antlr.trees_string_tree(s ,ruleNames_16 ,recog_16 ,) 
}

pub fn (mut s ParseContext) enter_rule_16(listener_32 antlr.ParseTreeListener) {mut listener_t,ok:=listener_32 
if ok {
listener_t.enter_logical_operator(s ,)
}
}

pub fn (mut s ParseContext) exit_rule_16(listener_33 antlr.ParseTreeListener) {mut listener_t,ok:=listener_33 
if ok {
listener_t.exit_logical_operator(s ,)
}
}

pub fn (mut p FilterExpressionSyntaxParser) logical_operator_1() (ILogicalOperatorContext, ) {mut localctx_19:=ILogicalOperatorContext{}
localctx_19=new_logical_operator_context(p ,p.get_parser_rule_context() ,p.get_state() ,)  
p.enter_rule(localctx_19 ,32 ,filter_expression_syntax_parser_rulelogical_operator ,)
mut _la:=0 
defer {p.exit_rule()
}
defer {mut err_2:=recover() 
if err_2  !=  unsafe { nil }  {
mut v_1,ok:=err_2 
if ok {
localctx_19.set_exception(v_1 ,)
p.get_error_handler.report_error(p ,v_1 ,)
p.get_error_handler.recover(p ,v_1 ,)
}else {
panic(err_2 ,)
}
}
}
p.enter_outer_alt(localctx_19 ,1 ,)
{p.set_state(219 ,)
_la=p.get_token_stream.la(1 ,)  
if ! ((((_la )  &  - (0x1f  +  1  )   )  ==  0   &&  ((1  <<  uint(_la ,)  )  &  ((1  <<  filter_expression_syntax_parser_t_18  )  |  (1  <<  filter_expression_syntax_parser_t_19  )   |  (1  <<  filter_expression_syntax_parser_k_and  )  )  )  !=  0   )  ||  _la  ==  filter_expression_syntax_parser_k_or   )  {
p.get_error_handler.recover_inline(p ,)
}else {
p.get_error_handler.report_match(p ,)
p.consume()
}
}
return localctx_19 
}

pub fn new_empty_bitwise_operator_context() (&ParseContext, ) {mut p:=new(ParseContext ,)  
p.base_parser_rule_context=antlr.new_base_parser_rule_context(unsafe { nil } ,- 1  ,)  
p.rule_index=filter_expression_syntax_parser_rulebitwise_operator  
return p 
}

pub fn (mut _ ParseContext) is_bitwise_operator_context() {}

pub fn new_bitwise_operator_context(parser_17 antlr.Parser, parent_17 antlr.ParserRuleContext, invokingState_17 int) (&ParseContext, ) {mut p:=new(ParseContext ,)  
p.base_parser_rule_context=antlr.new_base_parser_rule_context(parent_17 ,invokingState_17 ,)  
p.parser=parser_17  
p.rule_index=filter_expression_syntax_parser_rulebitwise_operator  
return p 
}

pub fn (mut s ParseContext) get_parser_17() (antlr.Parser, ) {return s.parser 
}

pub fn (mut s ParseContext) k_xor() (antlr.TerminalNode, ) {return s.get_token(filter_expression_syntax_parser_k_xor ,0 ,) 
}

pub fn (mut s ParseContext) get_rule_context_17() (antlr.RuleContext, ) {return s 
}

pub fn (mut s ParseContext) to_string_tree_17(ruleNames_17 []string, recog_17 antlr.Recognizer) (string, ) {return antlr.trees_string_tree(s ,ruleNames_17 ,recog_17 ,) 
}

pub fn (mut s ParseContext) enter_rule_17(listener_34 antlr.ParseTreeListener) {mut listener_t,ok:=listener_34 
if ok {
listener_t.enter_bitwise_operator(s ,)
}
}

pub fn (mut s ParseContext) exit_rule_17(listener_35 antlr.ParseTreeListener) {mut listener_t,ok:=listener_35 
if ok {
listener_t.exit_bitwise_operator(s ,)
}
}

pub fn (mut p FilterExpressionSyntaxParser) bitwise_operator_1() (IBitwiseOperatorContext, ) {mut localctx_20:=IBitwiseOperatorContext{}
localctx_20=new_bitwise_operator_context(p ,p.get_parser_rule_context() ,p.get_state() ,)  
p.enter_rule(localctx_20 ,34 ,filter_expression_syntax_parser_rulebitwise_operator ,)
mut _la:=0 
defer {p.exit_rule()
}
defer {mut err_2:=recover() 
if err_2  !=  unsafe { nil }  {
mut v_1,ok:=err_2 
if ok {
localctx_20.set_exception(v_1 ,)
p.get_error_handler.report_error(p ,v_1 ,)
p.get_error_handler.recover(p ,v_1 ,)
}else {
panic(err_2 ,)
}
}
}
p.enter_outer_alt(localctx_20 ,1 ,)
{p.set_state(221 ,)
_la=p.get_token_stream.la(1 ,)  
if ! ((((_la )  &  - (0x1f  +  1  )   )  ==  0   &&  ((1  <<  uint(_la ,)  )  &  ((1  <<  filter_expression_syntax_parser_t_20  )  |  (1  <<  filter_expression_syntax_parser_t_21  )   |  (1  <<  filter_expression_syntax_parser_t_22  )   |  (1  <<  filter_expression_syntax_parser_t_23  )   |  (1  <<  filter_expression_syntax_parser_t_24  )  )  )  !=  0   )  ||  _la  ==  filter_expression_syntax_parser_k_xor   )  {
p.get_error_handler.recover_inline(p ,)
}else {
p.get_error_handler.report_match(p ,)
p.consume()
}
}
return localctx_20 
}

pub fn new_empty_math_operator_context() (&ParseContext, ) {mut p:=new(ParseContext ,)  
p.base_parser_rule_context=antlr.new_base_parser_rule_context(unsafe { nil } ,- 1  ,)  
p.rule_index=filter_expression_syntax_parser_rulemath_operator  
return p 
}

pub fn (mut _ ParseContext) is_math_operator_context() {}

pub fn new_math_operator_context(parser_18 antlr.Parser, parent_18 antlr.ParserRuleContext, invokingState_18 int) (&ParseContext, ) {mut p:=new(ParseContext ,)  
p.base_parser_rule_context=antlr.new_base_parser_rule_context(parent_18 ,invokingState_18 ,)  
p.parser=parser_18  
p.rule_index=filter_expression_syntax_parser_rulemath_operator  
return p 
}

pub fn (mut s ParseContext) get_parser_18() (antlr.Parser, ) {return s.parser 
}

pub fn (mut s ParseContext) get_rule_context_18() (antlr.RuleContext, ) {return s 
}

pub fn (mut s ParseContext) to_string_tree_18(ruleNames_18 []string, recog_18 antlr.Recognizer) (string, ) {return antlr.trees_string_tree(s ,ruleNames_18 ,recog_18 ,) 
}

pub fn (mut s ParseContext) enter_rule_18(listener_36 antlr.ParseTreeListener) {mut listener_t,ok:=listener_36 
if ok {
listener_t.enter_math_operator(s ,)
}
}

pub fn (mut s ParseContext) exit_rule_18(listener_37 antlr.ParseTreeListener) {mut listener_t,ok:=listener_37 
if ok {
listener_t.exit_math_operator(s ,)
}
}

pub fn (mut p FilterExpressionSyntaxParser) math_operator_1() (IMathOperatorContext, ) {mut localctx_21:=IMathOperatorContext{}
localctx_21=new_math_operator_context(p ,p.get_parser_rule_context() ,p.get_state() ,)  
p.enter_rule(localctx_21 ,36 ,filter_expression_syntax_parser_rulemath_operator ,)
mut _la:=0 
defer {p.exit_rule()
}
defer {mut err_2:=recover() 
if err_2  !=  unsafe { nil }  {
mut v_1,ok:=err_2 
if ok {
localctx_21.set_exception(v_1 ,)
p.get_error_handler.report_error(p ,v_1 ,)
p.get_error_handler.recover(p ,v_1 ,)
}else {
panic(err_2 ,)
}
}
}
p.enter_outer_alt(localctx_21 ,1 ,)
{p.set_state(223 ,)
_la=p.get_token_stream.la(1 ,)  
if ! (((_la )  &  - (0x1f  +  1  )   )  ==  0   &&  ((1  <<  uint(_la ,)  )  &  ((1  <<  filter_expression_syntax_parser_t_2  )  |  (1  <<  filter_expression_syntax_parser_t_3  )   |  (1  <<  filter_expression_syntax_parser_t_25  )   |  (1  <<  filter_expression_syntax_parser_t_26  )   |  (1  <<  filter_expression_syntax_parser_t_27  )  )  )  !=  0   )  {
p.get_error_handler.recover_inline(p ,)
}else {
p.get_error_handler.report_match(p ,)
p.consume()
}
}
return localctx_21 
}

pub fn new_empty_function_name_context() (&ParseContext, ) {mut p:=new(ParseContext ,)  
p.base_parser_rule_context=antlr.new_base_parser_rule_context(unsafe { nil } ,- 1  ,)  
p.rule_index=filter_expression_syntax_parser_rulefunction_name  
return p 
}

pub fn (mut _ ParseContext) is_function_name_context() {}

pub fn new_function_name_context(parser_19 antlr.Parser, parent_19 antlr.ParserRuleContext, invokingState_19 int) (&ParseContext, ) {mut p:=new(ParseContext ,)  
p.base_parser_rule_context=antlr.new_base_parser_rule_context(parent_19 ,invokingState_19 ,)  
p.parser=parser_19  
p.rule_index=filter_expression_syntax_parser_rulefunction_name  
return p 
}

pub fn (mut s ParseContext) get_parser_19() (antlr.Parser, ) {return s.parser 
}

pub fn (mut s ParseContext) k_abs() (antlr.TerminalNode, ) {return s.get_token(filter_expression_syntax_parser_k_abs ,0 ,) 
}

pub fn (mut s ParseContext) k_ceiling() (antlr.TerminalNode, ) {return s.get_token(filter_expression_syntax_parser_k_ceiling ,0 ,) 
}

pub fn (mut s ParseContext) k_coalesce() (antlr.TerminalNode, ) {return s.get_token(filter_expression_syntax_parser_k_coalesce ,0 ,) 
}

pub fn (mut s ParseContext) k_convert() (antlr.TerminalNode, ) {return s.get_token(filter_expression_syntax_parser_k_convert ,0 ,) 
}

pub fn (mut s ParseContext) k_contains() (antlr.TerminalNode, ) {return s.get_token(filter_expression_syntax_parser_k_contains ,0 ,) 
}

pub fn (mut s ParseContext) k_dateadd() (antlr.TerminalNode, ) {return s.get_token(filter_expression_syntax_parser_k_dateadd ,0 ,) 
}

pub fn (mut s ParseContext) k_datediff() (antlr.TerminalNode, ) {return s.get_token(filter_expression_syntax_parser_k_datediff ,0 ,) 
}

pub fn (mut s ParseContext) k_datepart() (antlr.TerminalNode, ) {return s.get_token(filter_expression_syntax_parser_k_datepart ,0 ,) 
}

pub fn (mut s ParseContext) k_endswith() (antlr.TerminalNode, ) {return s.get_token(filter_expression_syntax_parser_k_endswith ,0 ,) 
}

pub fn (mut s ParseContext) k_floor() (antlr.TerminalNode, ) {return s.get_token(filter_expression_syntax_parser_k_floor ,0 ,) 
}

pub fn (mut s ParseContext) k_iif() (antlr.TerminalNode, ) {return s.get_token(filter_expression_syntax_parser_k_iif ,0 ,) 
}

pub fn (mut s ParseContext) k_indexof() (antlr.TerminalNode, ) {return s.get_token(filter_expression_syntax_parser_k_indexof ,0 ,) 
}

pub fn (mut s ParseContext) k_isdate() (antlr.TerminalNode, ) {return s.get_token(filter_expression_syntax_parser_k_isdate ,0 ,) 
}

pub fn (mut s ParseContext) k_isinteger() (antlr.TerminalNode, ) {return s.get_token(filter_expression_syntax_parser_k_isinteger ,0 ,) 
}

pub fn (mut s ParseContext) k_isguid() (antlr.TerminalNode, ) {return s.get_token(filter_expression_syntax_parser_k_isguid ,0 ,) 
}

pub fn (mut s ParseContext) k_isnull() (antlr.TerminalNode, ) {return s.get_token(filter_expression_syntax_parser_k_isnull ,0 ,) 
}

pub fn (mut s ParseContext) k_isnumeric() (antlr.TerminalNode, ) {return s.get_token(filter_expression_syntax_parser_k_isnumeric ,0 ,) 
}

pub fn (mut s ParseContext) k_lastindexof() (antlr.TerminalNode, ) {return s.get_token(filter_expression_syntax_parser_k_lastindexof ,0 ,) 
}

pub fn (mut s ParseContext) k_len() (antlr.TerminalNode, ) {return s.get_token(filter_expression_syntax_parser_k_len ,0 ,) 
}

pub fn (mut s ParseContext) k_lower() (antlr.TerminalNode, ) {return s.get_token(filter_expression_syntax_parser_k_lower ,0 ,) 
}

pub fn (mut s ParseContext) k_maxof() (antlr.TerminalNode, ) {return s.get_token(filter_expression_syntax_parser_k_maxof ,0 ,) 
}

pub fn (mut s ParseContext) k_minof() (antlr.TerminalNode, ) {return s.get_token(filter_expression_syntax_parser_k_minof ,0 ,) 
}

pub fn (mut s ParseContext) k_now() (antlr.TerminalNode, ) {return s.get_token(filter_expression_syntax_parser_k_now ,0 ,) 
}

pub fn (mut s ParseContext) k_nthindexof() (antlr.TerminalNode, ) {return s.get_token(filter_expression_syntax_parser_k_nthindexof ,0 ,) 
}

pub fn (mut s ParseContext) k_power() (antlr.TerminalNode, ) {return s.get_token(filter_expression_syntax_parser_k_power ,0 ,) 
}

pub fn (mut s ParseContext) k_regexmatch() (antlr.TerminalNode, ) {return s.get_token(filter_expression_syntax_parser_k_regexmatch ,0 ,) 
}

pub fn (mut s ParseContext) k_regexval() (antlr.TerminalNode, ) {return s.get_token(filter_expression_syntax_parser_k_regexval ,0 ,) 
}

pub fn (mut s ParseContext) k_replace() (antlr.TerminalNode, ) {return s.get_token(filter_expression_syntax_parser_k_replace ,0 ,) 
}

pub fn (mut s ParseContext) k_reverse() (antlr.TerminalNode, ) {return s.get_token(filter_expression_syntax_parser_k_reverse ,0 ,) 
}

pub fn (mut s ParseContext) k_round() (antlr.TerminalNode, ) {return s.get_token(filter_expression_syntax_parser_k_round ,0 ,) 
}

pub fn (mut s ParseContext) k_split() (antlr.TerminalNode, ) {return s.get_token(filter_expression_syntax_parser_k_split ,0 ,) 
}

pub fn (mut s ParseContext) k_sqrt() (antlr.TerminalNode, ) {return s.get_token(filter_expression_syntax_parser_k_sqrt ,0 ,) 
}

pub fn (mut s ParseContext) k_startswith() (antlr.TerminalNode, ) {return s.get_token(filter_expression_syntax_parser_k_startswith ,0 ,) 
}

pub fn (mut s ParseContext) k_strcount() (antlr.TerminalNode, ) {return s.get_token(filter_expression_syntax_parser_k_strcount ,0 ,) 
}

pub fn (mut s ParseContext) k_strcmp() (antlr.TerminalNode, ) {return s.get_token(filter_expression_syntax_parser_k_strcmp ,0 ,) 
}

pub fn (mut s ParseContext) k_substr() (antlr.TerminalNode, ) {return s.get_token(filter_expression_syntax_parser_k_substr ,0 ,) 
}

pub fn (mut s ParseContext) k_trim() (antlr.TerminalNode, ) {return s.get_token(filter_expression_syntax_parser_k_trim ,0 ,) 
}

pub fn (mut s ParseContext) k_trimleft() (antlr.TerminalNode, ) {return s.get_token(filter_expression_syntax_parser_k_trimleft ,0 ,) 
}

pub fn (mut s ParseContext) k_trimright() (antlr.TerminalNode, ) {return s.get_token(filter_expression_syntax_parser_k_trimright ,0 ,) 
}

pub fn (mut s ParseContext) k_upper() (antlr.TerminalNode, ) {return s.get_token(filter_expression_syntax_parser_k_upper ,0 ,) 
}

pub fn (mut s ParseContext) k_utcnow() (antlr.TerminalNode, ) {return s.get_token(filter_expression_syntax_parser_k_utcnow ,0 ,) 
}

pub fn (mut s ParseContext) get_rule_context_19() (antlr.RuleContext, ) {return s 
}

pub fn (mut s ParseContext) to_string_tree_19(ruleNames_19 []string, recog_19 antlr.Recognizer) (string, ) {return antlr.trees_string_tree(s ,ruleNames_19 ,recog_19 ,) 
}

pub fn (mut s ParseContext) enter_rule_19(listener_38 antlr.ParseTreeListener) {mut listener_t,ok:=listener_38 
if ok {
listener_t.enter_function_name(s ,)
}
}

pub fn (mut s ParseContext) exit_rule_19(listener_39 antlr.ParseTreeListener) {mut listener_t,ok:=listener_39 
if ok {
listener_t.exit_function_name(s ,)
}
}

pub fn (mut p FilterExpressionSyntaxParser) function_name() (IFunctionNameContext, ) {mut localctx_22:=IFunctionNameContext{}
localctx_22=new_function_name_context(p ,p.get_parser_rule_context() ,p.get_state() ,)  
p.enter_rule(localctx_22 ,38 ,filter_expression_syntax_parser_rulefunction_name ,)
mut _la:=0 
defer {p.exit_rule()
}
defer {mut err_2:=recover() 
if err_2  !=  unsafe { nil }  {
mut v_1,ok:=err_2 
if ok {
localctx_22.set_exception(v_1 ,)
p.get_error_handler.report_error(p ,v_1 ,)
p.get_error_handler.recover(p ,v_1 ,)
}else {
panic(err_2 ,)
}
}
}
p.enter_outer_alt(localctx_22 ,1 ,)
{p.set_state(225 ,)
_la=p.get_token_stream.la(1 ,)  
if ! ((((_la  -  29  )  &  - (0x1f  +  1  )   )  ==  0   &&  ((1  <<  uint((_la  -  29  ) ,)  )  &  ((1  <<  (filter_expression_syntax_parser_k_abs  -  29  )  )  |  (1  <<  (filter_expression_syntax_parser_k_ceiling  -  29  )  )   |  (1  <<  (filter_expression_syntax_parser_k_coalesce  -  29  )  )   |  (1  <<  (filter_expression_syntax_parser_k_convert  -  29  )  )   |  (1  <<  (filter_expression_syntax_parser_k_contains  -  29  )  )   |  (1  <<  (filter_expression_syntax_parser_k_dateadd  -  29  )  )   |  (1  <<  (filter_expression_syntax_parser_k_datediff  -  29  )  )   |  (1  <<  (filter_expression_syntax_parser_k_datepart  -  29  )  )   |  (1  <<  (filter_expression_syntax_parser_k_endswith  -  29  )  )   |  (1  <<  (filter_expression_syntax_parser_k_floor  -  29  )  )   |  (1  <<  (filter_expression_syntax_parser_k_iif  -  29  )  )   |  (1  <<  (filter_expression_syntax_parser_k_indexof  -  29  )  )   |  (1  <<  (filter_expression_syntax_parser_k_isdate  -  29  )  )   |  (1  <<  (filter_expression_syntax_parser_k_isinteger  -  29  )  )   |  (1  <<  (filter_expression_syntax_parser_k_isguid  -  29  )  )   |  (1  <<  (filter_expression_syntax_parser_k_isnull  -  29  )  )   |  (1  <<  (filter_expression_syntax_parser_k_isnumeric  -  29  )  )   |  (1  <<  (filter_expression_syntax_parser_k_lastindexof  -  29  )  )   |  (1  <<  (filter_expression_syntax_parser_k_len  -  29  )  )   |  (1  <<  (filter_expression_syntax_parser_k_lower  -  29  )  )   |  (1  <<  (filter_expression_syntax_parser_k_maxof  -  29  )  )   |  (1  <<  (filter_expression_syntax_parser_k_minof  -  29  )  )  )  )  !=  0   )  ||  (((_la  -  61  )  &  - (0x1f  +  1  )   )  ==  0   &&  ((1  <<  uint((_la  -  61  ) ,)  )  &  ((1  <<  (filter_expression_syntax_parser_k_now  -  61  )  )  |  (1  <<  (filter_expression_syntax_parser_k_nthindexof  -  61  )  )   |  (1  <<  (filter_expression_syntax_parser_k_power  -  61  )  )   |  (1  <<  (filter_expression_syntax_parser_k_regexmatch  -  61  )  )   |  (1  <<  (filter_expression_syntax_parser_k_regexval  -  61  )  )   |  (1  <<  (filter_expression_syntax_parser_k_replace  -  61  )  )   |  (1  <<  (filter_expression_syntax_parser_k_reverse  -  61  )  )   |  (1  <<  (filter_expression_syntax_parser_k_round  -  61  )  )   |  (1  <<  (filter_expression_syntax_parser_k_sqrt  -  61  )  )   |  (1  <<  (filter_expression_syntax_parser_k_split  -  61  )  )   |  (1  <<  (filter_expression_syntax_parser_k_startswith  -  61  )  )   |  (1  <<  (filter_expression_syntax_parser_k_strcount  -  61  )  )   |  (1  <<  (filter_expression_syntax_parser_k_strcmp  -  61  )  )   |  (1  <<  (filter_expression_syntax_parser_k_substr  -  61  )  )   |  (1  <<  (filter_expression_syntax_parser_k_trim  -  61  )  )   |  (1  <<  (filter_expression_syntax_parser_k_trimleft  -  61  )  )   |  (1  <<  (filter_expression_syntax_parser_k_trimright  -  61  )  )   |  (1  <<  (filter_expression_syntax_parser_k_upper  -  61  )  )   |  (1  <<  (filter_expression_syntax_parser_k_utcnow  -  61  )  )  )  )  !=  0   )  )  {
p.get_error_handler.recover_inline(p ,)
}else {
p.get_error_handler.report_match(p ,)
p.consume()
}
}
return localctx_22 
}

pub fn new_empty_function_expression_context() (&ParseContext, ) {mut p:=new(ParseContext ,)  
p.base_parser_rule_context=antlr.new_base_parser_rule_context(unsafe { nil } ,- 1  ,)  
p.rule_index=filter_expression_syntax_parser_rulefunction_expression  
return p 
}

pub fn (mut _ ParseContext) is_function_expression_context() {}

pub fn new_function_expression_context(parser_20 antlr.Parser, parent_20 antlr.ParserRuleContext, invokingState_20 int) (&ParseContext, ) {mut p:=new(ParseContext ,)  
p.base_parser_rule_context=antlr.new_base_parser_rule_context(parent_20 ,invokingState_20 ,)  
p.parser=parser_20  
p.rule_index=filter_expression_syntax_parser_rulefunction_expression  
return p 
}

pub fn (mut s ParseContext) get_parser_20() (antlr.Parser, ) {return s.parser 
}

pub fn (mut s ParseContext) function_name_1() (IFunctionNameContext, ) {mut t:=s.get_typed_rule_context(reflect.type_of.elem() ,0 ,)  
if t  ==  unsafe { nil }  {
return unsafe { nil } 
}
return t 
}

pub fn (mut s ParseContext) expression_list_2() (IExpressionListContext, ) {mut t:=s.get_typed_rule_context(reflect.type_of.elem() ,0 ,)  
if t  ==  unsafe { nil }  {
return unsafe { nil } 
}
return t 
}

pub fn (mut s ParseContext) get_rule_context_20() (antlr.RuleContext, ) {return s 
}

pub fn (mut s ParseContext) to_string_tree_20(ruleNames_20 []string, recog_20 antlr.Recognizer) (string, ) {return antlr.trees_string_tree(s ,ruleNames_20 ,recog_20 ,) 
}

pub fn (mut s ParseContext) enter_rule_20(listener_40 antlr.ParseTreeListener) {mut listener_t,ok:=listener_40 
if ok {
listener_t.enter_function_expression(s ,)
}
}

pub fn (mut s ParseContext) exit_rule_20(listener_41 antlr.ParseTreeListener) {mut listener_t,ok:=listener_41 
if ok {
listener_t.exit_function_expression(s ,)
}
}

pub fn (mut p FilterExpressionSyntaxParser) function_expression_1() (IFunctionExpressionContext, ) {mut localctx_23:=IFunctionExpressionContext{}
localctx_23=new_function_expression_context(p ,p.get_parser_rule_context() ,p.get_state() ,)  
p.enter_rule(localctx_23 ,40 ,filter_expression_syntax_parser_rulefunction_expression ,)
mut _la:=0 
defer {p.exit_rule()
}
defer {mut err_2:=recover() 
if err_2  !=  unsafe { nil }  {
mut v_1,ok:=err_2 
if ok {
localctx_23.set_exception(v_1 ,)
p.get_error_handler.report_error(p ,v_1 ,)
p.get_error_handler.recover(p ,v_1 ,)
}else {
panic(err_2 ,)
}
}
}
p.enter_outer_alt(localctx_23 ,1 ,)
{p.set_state(227 ,)
p.function_name()
}
{p.set_state(228 ,)
p.@match(filter_expression_syntax_parser_t_4 ,)
}
p.set_state(230 ,)
p.get_error_handler.sync(p ,)
_la=p.get_token_stream.la(1 ,)  
if (((_la )  &  - (0x1f  +  1  )   )  ==  0   &&  ((1  <<  uint(_la ,)  )  &  ((1  <<  filter_expression_syntax_parser_t_2  )  |  (1  <<  filter_expression_syntax_parser_t_3  )   |  (1  <<  filter_expression_syntax_parser_t_4  )   |  (1  <<  filter_expression_syntax_parser_t_6  )   |  (1  <<  filter_expression_syntax_parser_t_7  )   |  (1  <<  filter_expression_syntax_parser_k_abs  )  )  )  !=  0   )  ||  (((_la  -  34  )  &  - (0x1f  +  1  )   )  ==  0   &&  ((1  <<  uint((_la  -  34  ) ,)  )  &  ((1  <<  (filter_expression_syntax_parser_k_ceiling  -  34  )  )  |  (1  <<  (filter_expression_syntax_parser_k_coalesce  -  34  )  )   |  (1  <<  (filter_expression_syntax_parser_k_convert  -  34  )  )   |  (1  <<  (filter_expression_syntax_parser_k_contains  -  34  )  )   |  (1  <<  (filter_expression_syntax_parser_k_dateadd  -  34  )  )   |  (1  <<  (filter_expression_syntax_parser_k_datediff  -  34  )  )   |  (1  <<  (filter_expression_syntax_parser_k_datepart  -  34  )  )   |  (1  <<  (filter_expression_syntax_parser_k_endswith  -  34  )  )   |  (1  <<  (filter_expression_syntax_parser_k_floor  -  34  )  )   |  (1  <<  (filter_expression_syntax_parser_k_iif  -  34  )  )   |  (1  <<  (filter_expression_syntax_parser_k_indexof  -  34  )  )   |  (1  <<  (filter_expression_syntax_parser_k_isdate  -  34  )  )   |  (1  <<  (filter_expression_syntax_parser_k_isinteger  -  34  )  )   |  (1  <<  (filter_expression_syntax_parser_k_isguid  -  34  )  )   |  (1  <<  (filter_expression_syntax_parser_k_isnull  -  34  )  )   |  (1  <<  (filter_expression_syntax_parser_k_isnumeric  -  34  )  )   |  (1  <<  (filter_expression_syntax_parser_k_lastindexof  -  34  )  )   |  (1  <<  (filter_expression_syntax_parser_k_len  -  34  )  )   |  (1  <<  (filter_expression_syntax_parser_k_lower  -  34  )  )   |  (1  <<  (filter_expression_syntax_parser_k_maxof  -  34  )  )   |  (1  <<  (filter_expression_syntax_parser_k_minof  -  34  )  )   |  (1  <<  (filter_expression_syntax_parser_k_not  -  34  )  )   |  (1  <<  (filter_expression_syntax_parser_k_now  -  34  )  )   |  (1  <<  (filter_expression_syntax_parser_k_nthindexof  -  34  )  )   |  (1  <<  (filter_expression_syntax_parser_k_null  -  34  )  )  )  )  !=  0   )   ||  (((_la  -  66  )  &  - (0x1f  +  1  )   )  ==  0   &&  ((1  <<  uint((_la  -  66  ) ,)  )  &  ((1  <<  (filter_expression_syntax_parser_k_power  -  66  )  )  |  (1  <<  (filter_expression_syntax_parser_k_regexmatch  -  66  )  )   |  (1  <<  (filter_expression_syntax_parser_k_regexval  -  66  )  )   |  (1  <<  (filter_expression_syntax_parser_k_replace  -  66  )  )   |  (1  <<  (filter_expression_syntax_parser_k_reverse  -  66  )  )   |  (1  <<  (filter_expression_syntax_parser_k_round  -  66  )  )   |  (1  <<  (filter_expression_syntax_parser_k_sqrt  -  66  )  )   |  (1  <<  (filter_expression_syntax_parser_k_split  -  66  )  )   |  (1  <<  (filter_expression_syntax_parser_k_startswith  -  66  )  )   |  (1  <<  (filter_expression_syntax_parser_k_strcount  -  66  )  )   |  (1  <<  (filter_expression_syntax_parser_k_strcmp  -  66  )  )   |  (1  <<  (filter_expression_syntax_parser_k_substr  -  66  )  )   |  (1  <<  (filter_expression_syntax_parser_k_trim  -  66  )  )   |  (1  <<  (filter_expression_syntax_parser_k_trimleft  -  66  )  )   |  (1  <<  (filter_expression_syntax_parser_k_trimright  -  66  )  )   |  (1  <<  (filter_expression_syntax_parser_k_upper  -  66  )  )   |  (1  <<  (filter_expression_syntax_parser_k_utcnow  -  66  )  )   |  (1  <<  (filter_expression_syntax_parser_boolean_literal  -  66  )  )   |  (1  <<  (filter_expression_syntax_parser_identifier  -  66  )  )   |  (1  <<  (filter_expression_syntax_parser_integer_literal  -  66  )  )   |  (1  <<  (filter_expression_syntax_parser_numeric_literal  -  66  )  )   |  (1  <<  (filter_expression_syntax_parser_guid_literal  -  66  )  )   |  (1  <<  (filter_expression_syntax_parser_string_literal  -  66  )  )   |  (1  <<  (filter_expression_syntax_parser_datetime_literal  -  66  )  )  )  )  !=  0   )  {
{p.set_state(229 ,)
p.expression_list()
}
}
{p.set_state(232 ,)
p.@match(filter_expression_syntax_parser_t_5 ,)
}
return localctx_23 
}

pub fn new_empty_literal_value_context() (&ParseContext, ) {mut p:=new(ParseContext ,)  
p.base_parser_rule_context=antlr.new_base_parser_rule_context(unsafe { nil } ,- 1  ,)  
p.rule_index=filter_expression_syntax_parser_ruleliteral_value  
return p 
}

pub fn (mut _ ParseContext) is_literal_value_context() {}

pub fn new_literal_value_context(parser_21 antlr.Parser, parent_21 antlr.ParserRuleContext, invokingState_21 int) (&ParseContext, ) {mut p:=new(ParseContext ,)  
p.base_parser_rule_context=antlr.new_base_parser_rule_context(parent_21 ,invokingState_21 ,)  
p.parser=parser_21  
p.rule_index=filter_expression_syntax_parser_ruleliteral_value  
return p 
}

pub fn (mut s ParseContext) get_parser_21() (antlr.Parser, ) {return s.parser 
}

pub fn (mut s ParseContext) integer_literal_1() (antlr.TerminalNode, ) {return s.get_token(filter_expression_syntax_parser_integer_literal ,0 ,) 
}

pub fn (mut s ParseContext) numeric_literal() (antlr.TerminalNode, ) {return s.get_token(filter_expression_syntax_parser_numeric_literal ,0 ,) 
}

pub fn (mut s ParseContext) string_literal() (antlr.TerminalNode, ) {return s.get_token(filter_expression_syntax_parser_string_literal ,0 ,) 
}

pub fn (mut s ParseContext) datetime_literal() (antlr.TerminalNode, ) {return s.get_token(filter_expression_syntax_parser_datetime_literal ,0 ,) 
}

pub fn (mut s ParseContext) guid_literal_1() (antlr.TerminalNode, ) {return s.get_token(filter_expression_syntax_parser_guid_literal ,0 ,) 
}

pub fn (mut s ParseContext) boolean_literal() (antlr.TerminalNode, ) {return s.get_token(filter_expression_syntax_parser_boolean_literal ,0 ,) 
}

pub fn (mut s ParseContext) k_null_1() (antlr.TerminalNode, ) {return s.get_token(filter_expression_syntax_parser_k_null ,0 ,) 
}

pub fn (mut s ParseContext) get_rule_context_21() (antlr.RuleContext, ) {return s 
}

pub fn (mut s ParseContext) to_string_tree_21(ruleNames_21 []string, recog_21 antlr.Recognizer) (string, ) {return antlr.trees_string_tree(s ,ruleNames_21 ,recog_21 ,) 
}

pub fn (mut s ParseContext) enter_rule_21(listener_42 antlr.ParseTreeListener) {mut listener_t,ok:=listener_42 
if ok {
listener_t.enter_literal_value(s ,)
}
}

pub fn (mut s ParseContext) exit_rule_21(listener_43 antlr.ParseTreeListener) {mut listener_t,ok:=listener_43 
if ok {
listener_t.exit_literal_value(s ,)
}
}

pub fn (mut p FilterExpressionSyntaxParser) literal_value_1() (ILiteralValueContext, ) {mut localctx_24:=ILiteralValueContext{}
localctx_24=new_literal_value_context(p ,p.get_parser_rule_context() ,p.get_state() ,)  
p.enter_rule(localctx_24 ,42 ,filter_expression_syntax_parser_ruleliteral_value ,)
mut _la:=0 
defer {p.exit_rule()
}
defer {mut err_2:=recover() 
if err_2  !=  unsafe { nil }  {
mut v_1,ok:=err_2 
if ok {
localctx_24.set_exception(v_1 ,)
p.get_error_handler.report_error(p ,v_1 ,)
p.get_error_handler.recover(p ,v_1 ,)
}else {
panic(err_2 ,)
}
}
}
p.enter_outer_alt(localctx_24 ,1 ,)
{p.set_state(234 ,)
_la=p.get_token_stream.la(1 ,)  
if ! (((_la  -  63  )  &  - (0x1f  +  1  )   )  ==  0   &&  ((1  <<  uint((_la  -  63  ) ,)  )  &  ((1  <<  (filter_expression_syntax_parser_k_null  -  63  )  )  |  (1  <<  (filter_expression_syntax_parser_boolean_literal  -  63  )  )   |  (1  <<  (filter_expression_syntax_parser_integer_literal  -  63  )  )   |  (1  <<  (filter_expression_syntax_parser_numeric_literal  -  63  )  )   |  (1  <<  (filter_expression_syntax_parser_guid_literal  -  63  )  )   |  (1  <<  (filter_expression_syntax_parser_string_literal  -  63  )  )   |  (1  <<  (filter_expression_syntax_parser_datetime_literal  -  63  )  )  )  )  !=  0   )  {
p.get_error_handler.recover_inline(p ,)
}else {
p.get_error_handler.report_match(p ,)
p.consume()
}
}
return localctx_24 
}

pub fn new_empty_table_name_context() (&ParseContext, ) {mut p:=new(ParseContext ,)  
p.base_parser_rule_context=antlr.new_base_parser_rule_context(unsafe { nil } ,- 1  ,)  
p.rule_index=filter_expression_syntax_parser_ruletable_name  
return p 
}

pub fn (mut _ ParseContext) is_table_name_context() {}

pub fn new_table_name_context(parser_22 antlr.Parser, parent_22 antlr.ParserRuleContext, invokingState_22 int) (&ParseContext, ) {mut p:=new(ParseContext ,)  
p.base_parser_rule_context=antlr.new_base_parser_rule_context(parent_22 ,invokingState_22 ,)  
p.parser=parser_22  
p.rule_index=filter_expression_syntax_parser_ruletable_name  
return p 
}

pub fn (mut s ParseContext) get_parser_22() (antlr.Parser, ) {return s.parser 
}

pub fn (mut s ParseContext) identifier() (antlr.TerminalNode, ) {return s.get_token(filter_expression_syntax_parser_identifier ,0 ,) 
}

pub fn (mut s ParseContext) get_rule_context_22() (antlr.RuleContext, ) {return s 
}

pub fn (mut s ParseContext) to_string_tree_22(ruleNames_22 []string, recog_22 antlr.Recognizer) (string, ) {return antlr.trees_string_tree(s ,ruleNames_22 ,recog_22 ,) 
}

pub fn (mut s ParseContext) enter_rule_22(listener_44 antlr.ParseTreeListener) {mut listener_t,ok:=listener_44 
if ok {
listener_t.enter_table_name(s ,)
}
}

pub fn (mut s ParseContext) exit_rule_22(listener_45 antlr.ParseTreeListener) {mut listener_t,ok:=listener_45 
if ok {
listener_t.exit_table_name(s ,)
}
}

pub fn (mut p FilterExpressionSyntaxParser) table_name_1() (ITableNameContext, ) {mut localctx_25:=ITableNameContext{}
localctx_25=new_table_name_context(p ,p.get_parser_rule_context() ,p.get_state() ,)  
p.enter_rule(localctx_25 ,44 ,filter_expression_syntax_parser_ruletable_name ,)
defer {p.exit_rule()
}
defer {mut err_2:=recover() 
if err_2  !=  unsafe { nil }  {
mut v_1,ok:=err_2 
if ok {
localctx_25.set_exception(v_1 ,)
p.get_error_handler.report_error(p ,v_1 ,)
p.get_error_handler.recover(p ,v_1 ,)
}else {
panic(err_2 ,)
}
}
}
p.enter_outer_alt(localctx_25 ,1 ,)
{p.set_state(236 ,)
p.@match(filter_expression_syntax_parser_identifier ,)
}
return localctx_25 
}

pub fn new_empty_column_name_context() (&ParseContext, ) {mut p:=new(ParseContext ,)  
p.base_parser_rule_context=antlr.new_base_parser_rule_context(unsafe { nil } ,- 1  ,)  
p.rule_index=filter_expression_syntax_parser_rulecolumn_name  
return p 
}

pub fn (mut _ ParseContext) is_column_name_context() {}

pub fn new_column_name_context(parser_23 antlr.Parser, parent_23 antlr.ParserRuleContext, invokingState_23 int) (&ParseContext, ) {mut p:=new(ParseContext ,)  
p.base_parser_rule_context=antlr.new_base_parser_rule_context(parent_23 ,invokingState_23 ,)  
p.parser=parser_23  
p.rule_index=filter_expression_syntax_parser_rulecolumn_name  
return p 
}

pub fn (mut s ParseContext) get_parser_23() (antlr.Parser, ) {return s.parser 
}

pub fn (mut s ParseContext) identifier_1() (antlr.TerminalNode, ) {return s.get_token(filter_expression_syntax_parser_identifier ,0 ,) 
}

pub fn (mut s ParseContext) get_rule_context_23() (antlr.RuleContext, ) {return s 
}

pub fn (mut s ParseContext) to_string_tree_23(ruleNames_23 []string, recog_23 antlr.Recognizer) (string, ) {return antlr.trees_string_tree(s ,ruleNames_23 ,recog_23 ,) 
}

pub fn (mut s ParseContext) enter_rule_23(listener_46 antlr.ParseTreeListener) {mut listener_t,ok:=listener_46 
if ok {
listener_t.enter_column_name(s ,)
}
}

pub fn (mut s ParseContext) exit_rule_23(listener_47 antlr.ParseTreeListener) {mut listener_t,ok:=listener_47 
if ok {
listener_t.exit_column_name(s ,)
}
}

pub fn (mut p FilterExpressionSyntaxParser) column_name_1() (IColumnNameContext, ) {mut localctx_26:=IColumnNameContext{}
localctx_26=new_column_name_context(p ,p.get_parser_rule_context() ,p.get_state() ,)  
p.enter_rule(localctx_26 ,46 ,filter_expression_syntax_parser_rulecolumn_name ,)
defer {p.exit_rule()
}
defer {mut err_2:=recover() 
if err_2  !=  unsafe { nil }  {
mut v_1,ok:=err_2 
if ok {
localctx_26.set_exception(v_1 ,)
p.get_error_handler.report_error(p ,v_1 ,)
p.get_error_handler.recover(p ,v_1 ,)
}else {
panic(err_2 ,)
}
}
}
p.enter_outer_alt(localctx_26 ,1 ,)
{p.set_state(238 ,)
p.@match(filter_expression_syntax_parser_identifier ,)
}
return localctx_26 
}

pub fn new_empty_order_by_column_name_context() (&ParseContext, ) {mut p:=new(ParseContext ,)  
p.base_parser_rule_context=antlr.new_base_parser_rule_context(unsafe { nil } ,- 1  ,)  
p.rule_index=filter_expression_syntax_parser_ruleorder_by_column_name  
return p 
}

pub fn (mut _ ParseContext) is_order_by_column_name_context() {}

pub fn new_order_by_column_name_context(parser_24 antlr.Parser, parent_24 antlr.ParserRuleContext, invokingState_24 int) (&ParseContext, ) {mut p:=new(ParseContext ,)  
p.base_parser_rule_context=antlr.new_base_parser_rule_context(parent_24 ,invokingState_24 ,)  
p.parser=parser_24  
p.rule_index=filter_expression_syntax_parser_ruleorder_by_column_name  
return p 
}

pub fn (mut s ParseContext) get_parser_24() (antlr.Parser, ) {return s.parser 
}

pub fn (mut s ParseContext) identifier_2() (antlr.TerminalNode, ) {return s.get_token(filter_expression_syntax_parser_identifier ,0 ,) 
}

pub fn (mut s ParseContext) get_rule_context_24() (antlr.RuleContext, ) {return s 
}

pub fn (mut s ParseContext) to_string_tree_24(ruleNames_24 []string, recog_24 antlr.Recognizer) (string, ) {return antlr.trees_string_tree(s ,ruleNames_24 ,recog_24 ,) 
}

pub fn (mut s ParseContext) enter_rule_24(listener_48 antlr.ParseTreeListener) {mut listener_t,ok:=listener_48 
if ok {
listener_t.enter_order_by_column_name(s ,)
}
}

pub fn (mut s ParseContext) exit_rule_24(listener_49 antlr.ParseTreeListener) {mut listener_t,ok:=listener_49 
if ok {
listener_t.exit_order_by_column_name(s ,)
}
}

pub fn (mut p FilterExpressionSyntaxParser) order_by_column_name_1() (IOrderByColumnNameContext, ) {mut localctx_27:=IOrderByColumnNameContext{}
localctx_27=new_order_by_column_name_context(p ,p.get_parser_rule_context() ,p.get_state() ,)  
p.enter_rule(localctx_27 ,48 ,filter_expression_syntax_parser_ruleorder_by_column_name ,)
defer {p.exit_rule()
}
defer {mut err_2:=recover() 
if err_2  !=  unsafe { nil }  {
mut v_1,ok:=err_2 
if ok {
localctx_27.set_exception(v_1 ,)
p.get_error_handler.report_error(p ,v_1 ,)
p.get_error_handler.recover(p ,v_1 ,)
}else {
panic(err_2 ,)
}
}
}
p.enter_outer_alt(localctx_27 ,1 ,)
{p.set_state(240 ,)
p.@match(filter_expression_syntax_parser_identifier ,)
}
return localctx_27 
}

pub fn (mut p FilterExpressionSyntaxParser) sempred(localctx_28 antlr.RuleContext, ruleIndex int) (bool, ) { match ruleIndex {9 {
mut t:=&ParseContext(unsafe { nil } ) 
if localctx_28  !=  unsafe { nil }  {
t=localctx_28  
}
return p.expression__sempred(t ,pred_index ,) 
}
10 {
mut t_1:=&ParseContext(unsafe { nil } ) 
if localctx_28  !=  unsafe { nil }  {
t_1=localctx_28  
}
return p.predicate_expression__sempred(t_1 ,pred_index ,) 
}
11 {
mut t_2:=&ParseContext(unsafe { nil } ) 
if localctx_28  !=  unsafe { nil }  {
t_2=localctx_28  
}
return p.value_expression__sempred(t_2 ,pred_index ,) 
}
else{
panic("No predicate with index: "  +  NOT_YET_IMPLEMENTED  ,)
}
}
}

pub fn (mut p FilterExpressionSyntaxParser) expression__sempred(localctx_29 antlr.RuleContext, predIndex int) (bool, ) { match predIndex {0 {
return p.precpred(p.get_parser_rule_context() ,2 ,) 
}
else{
panic("No predicate with index: "  +  NOT_YET_IMPLEMENTED  ,)
}
}
}

pub fn (mut p FilterExpressionSyntaxParser) predicate_expression__sempred(localctx_30 antlr.RuleContext, predIndex_1 int) (bool, ) { match predIndex_1 {1 {
return p.precpred(p.get_parser_rule_context() ,3 ,) 
}
2 {
return p.precpred(p.get_parser_rule_context() ,2 ,) 
}
3 {
return p.precpred(p.get_parser_rule_context() ,5 ,) 
}
4 {
return p.precpred(p.get_parser_rule_context() ,4 ,) 
}
else{
panic("No predicate with index: "  +  NOT_YET_IMPLEMENTED  ,)
}
}
}

pub fn (mut p FilterExpressionSyntaxParser) value_expression__sempred(localctx_31 antlr.RuleContext, predIndex_2 int) (bool, ) { match predIndex_2 {5 {
return p.precpred(p.get_parser_rule_context() ,2 ,) 
}
6 {
return p.precpred(p.get_parser_rule_context() ,1 ,) 
}
else{
panic("No predicate with index: "  +  NOT_YET_IMPLEMENTED  ,)
}
}
}
