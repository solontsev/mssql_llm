use master;
go

exec sp_configure 'show advanced options', 1;
go

reconfigure;
go

exec sp_configure 'clr enabled', 1;
go

reconfigure;
go

create database [ai];
go

alter authorization on database::[ai] to [sa];
go

alter database [ai] set trustworthy on;
go

use [ai];
go

--exec sp_add_trusted_assembly 0x1601e33e5f180e905794fe934f83324083136547e11fcb2f7bf71f42605e8b4408e7f3cb4847857ff6b35f020d248cdc792719e027ea1cb49d2c6c7ae735154b,
--	N'SqlServerLlmClr, version=0.0.0.0, culture=neutral, publickeytoken=null, processorarchitecture=msil';
--go

create assembly [SqlServerLlmClr]
authorization [dbo]
from 0x4d5a90000300000004000000ffff0000b800000000000000400000000000000000000000000000000000000000000000000000000000000000000000800000000e1fba0e00b409cd21b8014ccd21546869732070726f6772616d2063616e6e6f742062652072756e20696e20444f53206d6f64652e0d0d0a2400000000000000504500004c010300019735d20000000000000000e00022200b013000002400000006000000000000be42000000200000006000000000001000200000000200000400000000000000060000000000000000a0000000020000000000000300608500001000001000000000100000100000000000001000000000000000000000006c4200004f00000000600000a803000000000000000000000000000000000000008000000c000000d8410000380000000000000000000000000000000000000000000000000000000000000000000000000000000000000000200000080000000000000000000000082000004800000000000000000000002e74657874000000c4220000002000000024000000020000000000000000000000000000200000602e72737263000000a8030000006000000004000000260000000000000000000000000000400000402e72656c6f6300000c0000000080000000020000002a00000000000000000000000000004000004200000000000000000000000000000000a0420000000000004800000002000500b4230000241e0000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000086281500000a7201000070281600000a281700000a6f1800000a027201000070512a00001330060062000000010000110328040000060a281500000a06281600000a281700000a6f1800000a721b00007003722700007002040328030000066f1900000a281a00000a0b281500000a07281600000a281700000a6f1800000a07731b00000a0c281500000a086f1c00000a2a00001330020047000000020000111200281d00000a7d020000041200027d040000041200037d050000041200047d030000041200157d0100000412007c020000041200280100002b12007c02000004281f00000a2a001b3004006e00000003000011722f0000707e2000000a0a721b00007002725f000070282100000a0b732200000a0c086f2300000a0708732400000a0d096f2500000a130411046f2600000a2c091104166f2700000a0ade2011042c0711046f2800000adc092c06096f2800000adc082c06086f2800000adc062a00000128000002003800144c000c00000000020030002858000a00000000020022004062000a000000001e02282900000a2a1b3006006801000004000011027b010000040a721c0e00700c72640e0070027b03000004281700000a0d1d8d24000001251672df0f0070a22517027b0400000472f70f007072fb0f00706f2a00000aa225187201100070a2251909a2251a721b100070a2251b027b05000004a2251c7233100070a2282b00000a130408282c00000a741b0000011305110572591000706f2d00000a110572991000706f2e00000a11056f2f00000a733000000a1306110611046f3100000a11066f3200000ade1006162f0b11062c0711066f2800000adc11056f3300000a742c0000016f3400000a733500000a130711076f3600000a72a310007013082511086f3700000a11086f3800000a5813092572bd10007011096f3900000a130a1109110a1109596f3a00000a72c310007072c91000706f2a00000a0bde2906162f0b11072c0711076f2800000adc130b021ffe7d01000004027c02000004110b283b00000ade14021ffe7d01000004027c0200000407283c00000a2a414c000002000000a300000012000000b5000000100000000000000002000000dd0000004d0000002a01000010000000000000000000000007000000330100003a010000190000001e00000136027c0200000403283d00000a2a000042534a4201000100000000000c00000076342e302e33303331390000000005006c000000a8040000237e000014050000e405000023537472696e677300000000f80a0000cc10000023555300c41b0000100000002347554944000000d41b00005002000023426c6f6200000000000000020000015717020a090a000000fa013300160000010000002d00000003000000050000000700000009000000010000003d000000130000000400000002000000020000000100000003000000010000000100000000009a030100000000000600b90216050600260316050600a401e4040f00360500000600cc01000406009c02000406007d02000406000d0300040600d90200040600f20200040600140200040600b801f70406009601f70406006002000406002f024c0306006305e6030a00fe01b3040a0092008a0506003a01e6030600e30116050600010045050a001f048a050a005a048a0506007b01160506002501e6030600e40016050e00b9056a0506009b043e00060076043e0006003004e60306000800160506004802e4040a00d105b3040a001d01b3040600a005e60306006903e6030a0012043a040a004d043a040600bf00e6030e00bd056a050600df033e000600a8043e000e0043016a050e003f016a05060083043e00000000003500000000000100010001001000ce040000410001000100030110002100000065000100060006006a01110106008e041401060054008b000600ac058b00060094038b0050200000000096007d001b0101007420000000009600ae0321010200e420000000009100ed03280105003821000000009100480033010800dc21000000008618de0406000900e42100000000e101c80506000900a42300000000e101f7002000090002000100d70500000100ac0500000200cb0000000300940300000100ac0500000200940300000300540000000100cb00000001000701030069000900de0401001100de0406001900de040a002900de0410003100de0410003900de0410004100de0410004900de0410005100de0410005900de0410006100de0415006900de0410007100de0410007900de0410008900de040600a100de041a00c100de040600d100c8050600d100f70020000101de0406000901140126001901d8002c0021015c0530001101a70010000c007505430021015c0548009100de04100011019d0050001400630161001400b3056a0014008b0377002101dc058b0021015c058e00b100de0410002901fb0306009100de049500910068049c0031017800a10031016603a50039015b0106008100de0406002101b700bd0021015c05c30041016301c90041012f0110004101ac0010004101d503d000e100de04d60051017501100051017a03060041014f01dd005901c303d000e900de04d60069018800e30021014403e70021018003ec0021014403f00021017003f60014002d04fc001400800502011400f700200020007b0021022e000b0038012e00130041012e001b0060012e00230069012e002b007e012e0033007e012e003b007e012e00430069012e004b0084012e0053007e012e005b007e012e0063009c012e006b00c6012e007300d30140007b00210260008300260263008b002102e000a3002102360056008000aa0003000c00250003000e0027003d005b00048000000100000000000000000000000000ce04000004000000000000000000000008016f000000000004000000000000000000000008016300000000000400000000000000000000000801e60300000000030002003d0072000000005461736b6031004173796e635461736b4d6574686f644275696c6465726031003c47657453716c46726f6d4c6c6d3e645f5f32003c4d6f64756c653e0053797374656d2e494f004765744462536368656d61006461746162617365536368656d610053797374656d2e44617461006d73636f726c696200526561640048656c6c6f576f726c640052656164546f456e640053716c436f6d6d616e640045786563757465416e6453656e64007365745f4d6574686f64005265706c6163650049446973706f7361626c650064617461626173654e616d65006765745f4e65774c696e6500494173796e6353746174654d616368696e650053657453746174654d616368696e650073746174654d616368696e65006765745f506970650053716c506970650056616c756554797065007365745f436f6e74656e74547970650048747470576562526573706f6e736500476574526573706f6e736500446973706f736500437265617465003c3e315f5f737461746500577269746500436f6d70696c657247656e65726174656441747472696275746500477569644174747269627574650044656275676761626c6541747472696275746500436f6d56697369626c6541747472696275746500417373656d626c795469746c65417474726962757465004173796e6353746174654d616368696e654174747269627574650053716c50726f63656475726541747472696275746500417373656d626c7954726164656d61726b417474726962757465005461726765744672616d65776f726b41747472696275746500446562756767657248696464656e41747472696275746500417373656d626c7946696c6556657273696f6e41747472696275746500417373656d626c79436f6e66696775726174696f6e41747472696275746500417373656d626c794465736372697074696f6e41747472696275746500436f6d70696c6174696f6e52656c61786174696f6e7341747472696275746500417373656d626c7950726f6475637441747472696275746500417373656d626c79436f7079726967687441747472696275746500417373656d626c79436f6d70616e794174747269627574650052756e74696d65436f6d7061746962696c69747941747472696275746500496e6465784f660053797374656d2e52756e74696d652e56657273696f6e696e6700476574537472696e6700537562737472696e6700466c757368006765745f4c656e677468006765745f5461736b006d6f64656c0053716c5365727665724c6c6d436c722e646c6c0047656e65726174416e644578656375746553716c00476574526573706f6e736553747265616d004765745265717565737453747265616d0053797374656d0047657453716c46726f6d4c6c6d004f70656e0053797374656d2e5265666c656374696f6e004462436f6e6e656374696f6e0053716c436f6e6e656374696f6e00536574457863657074696f6e0053797374656d2e446174612e436f6d6d6f6e004462446174615265616465720053716c4461746152656164657200457865637574655265616465720053747265616d5265616465720054657874526561646572003c3e745f5f6275696c6465720053747265616d5772697465720054657874577269746572004d6963726f736f66742e53716c5365727665722e5365727665720053716c5365727665724c6c6d436c72002e63746f720053797374656d2e446961676e6f73746963730053797374656d2e52756e74696d652e496e7465726f7053657276696365730053797374656d2e52756e74696d652e436f6d70696c6572536572766963657300446562756767696e674d6f6465730053797374656d2e546872656164696e672e5461736b7300436f6e636174004f626a6563740053797374656d2e4e6574006765745f526573756c7400536574526573756c740053797374656d2e446174612e53716c436c69656e7400456e7669726f6e6d656e740070726f6d7074005374617274004874747057656252657175657374004d6f76654e6578740053716c436f6e7465787400456d7074790000000019480065006c006c006f00200077006f0072006c0064002100000b75007300650020005b0000075d003b002000002f63006f006e007400650078007400200063006f006e006e0065006300740069006f006e003d007400720075006500008dbb5d003b000d000a002d002d002000540065006d0070006f00720061007200790020007400610062006c006500200074006f00200068006f006c0064002000740068006500200063006f006e0063006100740065006e006100740065006400200063006f006c0075006d006e00200064006500660069006e006900740069006f006e0073000d000a004400450043004c004100520045002000400043006f006c0075006d006e0044006500660069006e006900740069006f006e00730020005400410042004c004500200028005400610062006c0065004e0061006d00650020004e005600410052004300480041005200280031003200380029002c00200043006f006c0075006d006e0044006500660069006e006900740069006f006e0020004e00560041005200430048004100520028004d0041005800290029003b000d000a000d000a002d002d00200050006f00700075006c0061007400650020007400680065002000740065006d0070006f00720061007200790020007400610062006c00650020007700690074006800200063006f006c0075006d006e00200064006500660069006e006900740069006f006e007300200066006f0072002000650061006300680020007400610062006c0065000d000a0049004e005300450052005400200049004e0054004f002000400043006f006c0075006d006e0044006500660069006e006900740069006f006e007300200028005400610062006c0065004e0061006d0065002c00200043006f006c0075006d006e0044006500660069006e006900740069006f006e0029000d000a00530045004c004500430054000d000a00200020002000200074002e005400410042004c0045005f0053004300480045004d00410020002b00200027005d002e005b00270020002b00200074002e005400410042004c0045005f004e0041004d0045002c000d000a0020002000200020002700200020005b00270020002b00200063002e0043004f004c0055004d004e005f004e0041004d00450020002b00200027005d002000270020002b00200063002e0044004100540041005f00540059005000450020002b000d000a002000200020002000430041005300450020000d000a00200020002000200020002000200020005700480045004e00200063002e0044004100540041005f005400590050004500200049004e00200028002700630068006100720027002c0020002700760061007200630068006100720027002c00200027006e00630068006100720027002c00200027006e0076006100720063006800610072002700290020000d000a0020002000200020002000200020002000200020002000200020005400480045004e00200027002800270020002b0020004300410053005400280063002e004300480041005200410043005400450052005f004d004100580049004d0055004d005f004c0045004e0047005400480020004100530020004e005600410052004300480041005200290020002b0020002700290027000d000a00200020002000200020002000200020005700480045004e00200063002e0044004100540041005f005400590050004500200049004e0020002800270064006500630069006d0061006c0027002c00200027006e0075006d0065007200690063002700290020000d000a0020002000200020002000200020002000200020002000200020005400480045004e00200027002800270020002b0020004300410053005400280063002e004e0055004d0045005200490043005f0050005200450043004900530049004f004e0020004100530020004e005600410052004300480041005200290020002b00200027002c00270020002b0020004300410053005400280063002e004e0055004d0045005200490043005f005300430041004c00450020004100530020004e005600410052004300480041005200290020002b0020002700290027000d000a002000200020002000200020002000200045004c00530045002000270027000d000a00200020002000200045004e00440020002b000d000a002000200020002000430041005300450020000d000a00200020002000200020002000200020005700480045004e00200063002e00490053005f004e0055004c004c00410042004c00450020003d00200027004e004f00270020005400480045004e002000270020004e004f00540020004e0055004c004c0027000d000a002000200020002000200020002000200045004c00530045002000270020004e0055004c004c0027000d000a00200020002000200045004e00440020002b00200027002c00200027000d000a00460052004f004d00200049004e0046004f0052004d004100540049004f004e005f0053004300480045004d0041002e005400410042004c0045005300200074000d000a0049004e004e004500520020004a004f0049004e00200049004e0046004f0052004d004100540049004f004e005f0053004300480045004d0041002e0043004f004c0055004d004e005300200063000d000a0020002000200020004f004e00200074002e005400410042004c0045005f004e0041004d00450020003d00200063002e005400410042004c0045005f004e0041004d004500200041004e004400200074002e005400410042004c0045005f0053004300480045004d00410020003d00200063002e005400410042004c0045005f0053004300480045004d0041000d000a0057004800450052004500200074002e005400410042004c0045005f00540059005000450020003d0020002700420041005300450020005400410042004c00450027003b000d000a000d000a002d002d00200043006f006e00730074007200750063007400200043005200450041005400450020005400410042004c0045002000730074006100740065006d0065006e007400730020007500730069006e006700200046004f005200200058004d004c00200050004100540048000d000a004400450043004c00410052004500200040004300720065006100740065005400610062006c006500530074006100740065006d0065006e007400730020004e00560041005200430048004100520028004d0041005800290020003d002000270027003b000d000a000d000a00530045004c00450043005400200040004300720065006100740065005400610062006c006500530074006100740065006d0065006e007400730020003d00200053005400550046004600280028000d000a002000200020002000530045004c0045004300540020004300480041005200280031003300290020002b0020004300480041005200280031003000290020002b000d000a002000200020002000200020002000200020002000200027005400410042004c00450020005b00270020002b0020005400610062006c0065004e0061006d00650020002b00200027005d002c00200063006f006c0075006d006e0073003a002000270020002b000d000a002000200020002000200020002000200020002000200053005400550046004600280028000d000a00200020002000200020002000200020002000200020002000200020002000530045004c00450043005400200043006f006c0075006d006e0044006500660069006e006900740069006f006e000d000a00200020002000200020002000200020002000200020002000200020002000460052004f004d002000400043006f006c0075006d006e0044006500660069006e006900740069006f006e0073000d000a002000200020002000200020002000200020002000200020002000200020005700480045005200450020005400610062006c0065004e0061006d00650020003d00200074002e005400610062006c0065004e0061006d0065000d000a002000200020002000200020002000200020002000200020002000200020004f005200440045005200200042005900200043006f006c0075006d006e0044006500660069006e006900740069006f006e000d000a0020002000200020002000200020002000200020002000200020002000200046004f005200200058004d004c002000500041005400480028002700270029002c002000540059005000450029002e00760061006c0075006500280027002e0027002c00200027004e00560041005200430048004100520028004d00410058002900270029002c00200031002c00200032002c00200027002700290020002b000d000a00200020002000200020002000200020002000200020002700270020004100530020004300720065006100740065005400610062006c006500530074006100740065006d0065006e0074000d000a002000200020002000460052004f004d0020002800530045004c004500430054002000440049005300540049004e004300540020005400610062006c0065004e0061006d0065002000460052004f004d002000400043006f006c0075006d006e0044006500660069006e006900740069006f006e0073002900200074000d000a00200020002000200046004f005200200058004d004c002000500041005400480028002700270029002c002000540059005000450029002e00760061006c0075006500280027002e0027002c00200027004e00560041005200430048004100520028004d00410058002900270029002c00200031002c00200032002c0020002700270029003b000d000a000d000a00730065006c00650063007400200040004300720065006100740065005400610062006c006500530074006100740065006d0065006e0074007300200061007300200072006500730075006c0074003b00014768007400740070003a002f002f006c006f00630061006c0068006f00730074003a00310031003400330034002f006100700069002f00670065006e006500720061007400650000817959006f0075002000610072006500200061002000530051004c00200053006500720076006500720020004500780070006500720074002e00200054006800650020006f00750074007000750074002000730068006f0075006c006400200063006f006e007300690073007400200073006f006c0065006c00790020006f0066002000740068006500200054002d00530051004c0020007100750065007200790020006f006e006c0079002c002000770069007400680020006e006f0020006100640064006900740069006f006e0061006c002000740065007800740020006f00720020006500780070006c0061006e006100740069006f006e0073002e00200059006f007500270072006500200077006f0072006b0069006e006700200069006e00730069006400650020006100200064006100740061006200610073006500200077006900740068002000740068006500200066006f006c006c006f00770069006e006700200073006300680065006d0061003a00200001177b002200700072006f006d007000740022003a0022000003220000055c002200001922002c002200730079007300740065006d0022003a002200001722002c0022006d006f00640065006c0022003a002200002522002c0020002200730074007200650061006d0022003a00660061006c00730065007d00003f6100700070006c00690063006100740069006f006e002f006a0073006f006e003b00200063006800610072007300650074003d007500740066002d003800010950004f00530054000019220072006500730070006f006e007300650022003a002200000522002c0000055c005c0000010000cd8441e8bb493e4382d8e82ffa03b40200042001010803200001052001011111042001010e042001010205200101124d0520010112690500001280890300000e0500020e0e0e0607030e0e124905151255010e04200013000700040e0e0e0e0e052001011249040701110c0515117d010e08000015117d0113000730010101101e00040a01110c0820001512550113000a07050e0e12591249125d02060e0600030e0e0e0e062002010e1259042000125d032000020420010e0812070c080e0e0e0e126d127112750e080812790520020e0e0e0500010e1d0e0600011280a10e0520001280a5062001011280a50520001280ad0320000e042001080e03200008052002080e080520020e080805200101127905200101130008b77a5c561934e089020608060615117d010e05000101100e060003010e0e0e0a0003151255010e0e0e0e0400010e0e0801000800000000001e01000100540216577261704e6f6e457863657074696f6e5468726f7773010801000200000000001401000f53716c5365727665724c6c6d436c72000005010000000017010012436f7079726967687420c2a920203230323400002901002431356634326337662d366234332d346439632d626134612d63616362633638336530646400000c010007312e302e302e3000004d01001c2e4e45544672616d65776f726b2c56657273696f6e3d76342e382e310100540e144672616d65776f726b446973706c61794e616d65142e4e4554204672616d65776f726b20342e382e3104010000002801002353716c5365727665724c6c6d436c722b3c47657453716c46726f6d4c6c6d3e645f5f3200000000000000ec3a3e8d00000000020000005c00000010420000102400000000000000000000000000001000000000000000000000000000000052534453ea1946fe1a94ce44b69ee182c546759e01000000443a5c6769746875625c6d7373716c5f6c6c6d5c53716c5365727665724c6c6d436c725c6f626a5c52656c656173655c53716c5365727665724c6c6d436c722e70646200944200000000000000000000ae420000002000000000000000000000000000000000000000000000a0420000000000000000000000005f436f72446c6c4d61696e006d73636f7265652e646c6c0000000000ff250020001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001001000000018000080000000000000000000000000000001000100000030000080000000000000000000000000000001000000000048000000586000004c03000000000000000000004c0334000000560053005f00560045005200530049004f004e005f0049004e0046004f0000000000bd04effe00000100000001000000000000000100000000003f000000000000000400000002000000000000000000000000000000440000000100560061007200460069006c00650049006e0066006f00000000002400040000005400720061006e0073006c006100740069006f006e00000000000000b004ac020000010053007400720069006e006700460069006c00650049006e0066006f0000008802000001003000300030003000300034006200300000001a000100010043006f006d006d0065006e007400730000000000000022000100010043006f006d00700061006e0079004e0061006d0065000000000000000000480010000100460069006c0065004400650073006300720069007000740069006f006e0000000000530071006c005300650072007600650072004c006c006d0043006c0072000000300008000100460069006c006500560065007200730069006f006e000000000031002e0030002e0030002e003000000048001400010049006e007400650072006e0061006c004e0061006d0065000000530071006c005300650072007600650072004c006c006d0043006c0072002e0064006c006c0000004800120001004c006500670061006c0043006f007000790072006900670068007400000043006f0070007900720069006700680074002000a90020002000320030003200340000002a00010001004c006500670061006c00540072006100640065006d00610072006b00730000000000000000005000140001004f0072006900670069006e0061006c00460069006c0065006e0061006d0065000000530071006c005300650072007600650072004c006c006d0043006c0072002e0064006c006c000000400010000100500072006f0064007500630074004e0061006d00650000000000530071006c005300650072007600650072004c006c006d0043006c0072000000340008000100500072006f006400750063007400560065007200730069006f006e00000031002e0030002e0030002e003000000038000800010041007300730065006d0062006c0079002000560065007200730069006f006e00000031002e0030002e0030002e00300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004000000c000000c03200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
with permission_set = unsafe
go

create procedure [dbo].[hello_world] @out nvarchar(255) output
with execute as caller
as
external name [SqlServerLlmClr].[SqlServerLlmClr].[HelloWorld]
go

declare @out nvarchar(255);
exec [dbo].[hello_world] @out output;
select @out as output;
go

create procedure [dbo].[generate_and_execute_sql] @prompt nvarchar(max), @db_name sysname, @model sysname
with execute as caller
as
external name [SqlServerLlmClr].[SqlServerLlmClr].[GeneratAndExecuteSql]
go

exec [dbo].[generate_and_execute_sql] @prompt = 'show me all users', @db_name = 'TEST', @model = 'mistral';
go

exec [dbo].[generate_and_execute_sql] @prompt = 'Who is the oldest user?', @db_name = 'TEST', @model = 'mistral';
go


exec [dbo].[generate_and_execute_sql] @prompt = 'how many people work in my company', @db_name = 'AdventureWorks2022', @model = 'mistral';
go

exec [dbo].[generate_and_execute_sql] @prompt = 'return top 5 cities where employees live', @db_name = 'AdventureWorks2022', @model = 'mistral';
go
