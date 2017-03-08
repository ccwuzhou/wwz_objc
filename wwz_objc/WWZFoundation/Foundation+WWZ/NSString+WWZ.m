//
//  NSString+WWZ.m
//  wwz_objc
//
//  Created by wwz on 17/3/6.
//  Copyright © 2017年 tijio. All rights reserved.
//

#import "NSString+WWZ.h"

#import <objc/runtime.h>
#import <CommonCrypto/CommonHMAC.h>

#define HANZI_START 19968
#define HANZI_COUNT 20902

static char firstLetterArray[HANZI_COUNT] =
"ydkqsxnwzssxjbymgcczqpssqbycdscdqldylybssjgyqzjjfgcclzznwdwzjljpfyynnjjtmynzwzhflzppqhgccyynmjqyxxgd"
"nnsnsjnjnsnnmlnrxyfsngnnnnqzggllyjlnyzssecykyyhqwjssggyxyqyjtwktjhychmnxjtlhjyqbyxdldwrrjnwysrldzjpc"
"bzjjbrcfslnczstzfxxchtrqggddlyccssymmrjcyqzpwwjjyfcrwfdfzqpyddwyxkyjawjffxjbcftzyhhycyswccyxsclcxxwz"
"cxnbgnnxbxlzsqsbsjpysazdhmdzbqbscwdzzyytzhbtsyyfzgntnxjywqnknphhlxgybfmjnbjhhgqtjcysxstkzglyckglysmz"
"xyalmeldccxgzyrjxjzlnjzcqkcnnjwhjczccqljststbnhbtyxceqxkkwjyflzqlyhjxspsfxlmpbysxxxytccnylllsjxfhjxp"
"jbtffyabyxbcczbzyclwlczggbtssmdtjcxpthyqtgjjxcjfzkjzjqnlzwlslhdzbwjncjzyzsqnycqynzcjjwybrtwpyftwexcs"
"kdzctbyhyzqyyjxzcfbzzmjyxxsdczottbzljwfckscsxfyrlrygmbdthjxsqjccsbxyytswfbjdztnbcnzlcyzzpsacyzzsqqcs"
"hzqydxlbpjllmqxqydzxsqjtzpxlcglqdcwzfhctdjjsfxjejjtlbgxsxjmyjjqpfzasyjnsydjxkjcdjsznbartcclnjqmwnqnc"
"lllkbdbzzsyhqcltwlccrshllzntylnewyzyxczxxgdkdmtcedejtsyyssdqdfmxdbjlkrwnqlybglxnlgtgxbqjdznyjsjyjcjm"
"rnymgrcjczgjmzmgxmmryxkjnymsgmzzymknfxmbdtgfbhcjhkylpfmdxlxjjsmsqgzsjlqdldgjycalcmzcsdjllnxdjffffjcn"
"fnnffpfkhkgdpqxktacjdhhzdddrrcfqyjkqccwjdxhwjlyllzgcfcqjsmlzpbjjblsbcjggdckkdezsqcckjgcgkdjtjllzycxk"
"lqccgjcltfpcqczgwbjdqyzjjbyjhsjddwgfsjgzkcjctllfspkjgqjhzzljplgjgjjthjjyjzccmlzlyqbgjwmljkxzdznjqsyz"
"mljlljkywxmkjlhskjhbmclyymkxjqlbmllkmdxxkwyxwslmlpsjqqjqxyqfjtjdxmxxllcrqbsyjbgwynnggbcnxpjtgpapfgdj"
"qbhbncfjyzjkjkhxqfgqckfhygkhdkllsdjqxpqyaybnqsxqnszswhbsxwhxwbzzxdmndjbsbkbbzklylxgwxjjwaqzmywsjqlsj"
"xxjqwjeqxnchetlzalyyyszzpnkyzcptlshtzcfycyxyljsdcjqagyslcllyyysslqqqnldxzsccscadycjysfsgbfrsszqsbxjp"
"sjysdrckgjlgtkzjzbdktcsyqpyhstcldjnhmymcgxyzhjdctmhltxzhylamoxyjcltyfbqqjpfbdfehthsqhzywwcncxcdwhowg"
"yjlegmdqcwgfjhcsntmydolbygnqwesqpwnmlrydzszzlyqpzgcwxhnxpyxshmdqjgztdppbfbhzhhjyfdzwkgkzbldnzsxhqeeg"
"zxylzmmzyjzgszxkhkhtxexxgylyapsthxdwhzydpxagkydxbhnhnkdnjnmyhylpmgecslnzhkxxlbzzlbmlsfbhhgsgyyggbhsc"
"yajtxglxtzmcwzydqdqmngdnllszhngjzwfyhqswscelqajynytlsxthaznkzzsdhlaxxtwwcjhqqtddwzbcchyqzflxpslzqgpz"
"sznglydqtbdlxntctajdkywnsyzljhhdzckryyzywmhychhhxhjkzwsxhdnxlyscqydpslyzwmypnkxyjlkchtyhaxqsyshxasmc"
"hkdscrsgjpwqsgzjlwwschsjhsqnhnsngndantbaalczmsstdqjcjktscjnxplggxhhgoxzcxpdmmhldgtybynjmxhmrzplxjzck"
"zxshflqxxcdhxwzpckczcdytcjyxqhlxdhypjqxnlsyydzozjnhhqezysjyayxkypdgxddnsppyzndhthrhxydpcjjhtcnnctlhb"
"ynyhmhzllnnxmylllmdcppxhmxdkycyrdltxjchhznxclcclylnzsxnjzzlnnnnwhyqsnjhxynttdkyjpychhyegkcwtwlgjrlgg"
"tgtygyhpyhylqyqgcwyqkpyyettttlhyylltyttsylnyzwgywgpydqqzzdqnnkcqnmjjzzbxtqfjkdffbtkhzkbxdjjkdjjtlbwf"
"zpptkqtztgpdwntpjyfalqmkgxbcclzfhzcllllanpnxtjklcclgyhdzfgyddgcyyfgydxkssendhykdndknnaxxhbpbyyhxccga"
"pfqyjjdmlxcsjzllpcnbsxgjyndybwjspcwjlzkzddtacsbkzdyzypjzqsjnkktknjdjgyepgtlnyqnacdntcyhblgdzhbbydmjr"
"egkzyheyybjmcdtafzjzhgcjnlghldwxjjkytcyksssmtwcttqzlpbszdtwcxgzagyktywxlnlcpbclloqmmzsslcmbjcsdzkydc"
"zjgqjdsmcytzqqlnzqzxssbpkdfqmddzzsddtdmfhtdycnaqjqkypbdjyyxtljhdrqxlmhkydhrnlklytwhllrllrcxylbnsrnzz"
"symqzzhhkyhxksmzsyzgcxfbnbsqlfzxxnnxkxwymsddyqnggqmmyhcdzttfgyyhgsbttybykjdnkyjbelhdypjqnfxfdnkzhqks"
"byjtzbxhfdsbdaswpawajldyjsfhblcnndnqjtjnchxfjsrfwhzfmdrfjyxwzpdjkzyjympcyznynxfbytfyfwygdbnzzzdnytxz"
"emmqbsqehxfznbmflzzsrsyqjgsxwzjsprytjsjgskjjgljjynzjjxhgjkymlpyyycxycgqzswhwlyrjlpxslcxmnsmwklcdnkny"
"npsjszhdzeptxmwywxyysywlxjqcqxzdclaeelmcpjpclwbxsqhfwrtfnjtnqjhjqdxhwlbyccfjlylkyynldxnhycstyywncjtx"
"ywtrmdrqnwqcmfjdxzmhmayxnwmyzqtxtlmrspwwjhanbxtgzypxyyrrclmpamgkqjszycymyjsnxtplnbappypylxmyzkynldgy"
"jzcchnlmzhhanqnbgwqtzmxxmllhgdzxnhxhrxycjmffxywcfsbssqlhnndycannmtcjcypnxnytycnnymnmsxndlylysljnlxys"
"sqmllyzlzjjjkyzzcsfbzxxmstbjgnxnchlsnmcjscyznfzlxbrnnnylmnrtgzqysatswryhyjzmgdhzgzdwybsscskxsyhytsxg"
"cqgxzzbhyxjscrhmkkbsczjyjymkqhzjfnbhmqhysnjnzybknqmcjgqhwlsnzswxkhljhyybqcbfcdsxdldspfzfskjjzwzxsddx"
"jseeegjscssygclxxnwwyllymwwwgydkzjggggggsycknjwnjpcxbjjtqtjwdsspjxcxnzxnmelptfsxtllxcljxjjljsxctnswx"
"lennlyqrwhsycsqnybyaywjejqfwqcqqcjqgxaldbzzyjgkgxbltqyfxjltpydkyqhpmatlcndnkxmtxynhklefxdllegqtymsaw"
"hzmljtkynxlyjzljeeyybqqffnlyxhdsctgjhxywlkllxqkcctnhjlqmkkzgcyygllljdcgydhzwypysjbzjdzgyzzhywyfqdtyz"
"szyezklymgjjhtsmqwyzljyywzcsrkqyqltdxwcdrjalwsqzwbdcqyncjnnszjlncdcdtlzzzacqqzzddxyblxcbqjylzllljddz"
"jgyqyjzyxnyyyexjxksdaznyrdlzyyynjlslldyxjcykywnqcclddnyyynycgczhjxcclgzqjgnwnncqqjysbzzxyjxjnxjfzbsb"
"dsfnsfpzxhdwztdmpptflzzbzdmyypqjrsdzsqzsqxbdgcpzswdwcsqzgmdhzxmwwfybpngphdmjthzsmmbgzmbzjcfzhfcbbnmq"
"dfmbcmcjxlgpnjbbxgyhyyjgptzgzmqbqdcgybjxlwnkydpdymgcftpfxyztzxdzxtgkptybbclbjaskytssqyymscxfjhhlslls"
"jpqjjqaklyldlycctsxmcwfgngbqxllllnyxtyltyxytdpjhnhgnkbyqnfjyyzbyyessessgdyhfhwtcqbsdzjtfdmxhcnjzymqw"
"srxjdzjqbdqbbsdjgnfbknbxdkqhmkwjjjgdllthzhhyyyyhhsxztyyyccbdbpypzyccztjpzywcbdlfwzcwjdxxhyhlhwczxjtc"
"nlcdpxnqczczlyxjjcjbhfxwpywxzpcdzzbdccjwjhmlxbqxxbylrddgjrrctttgqdczwmxfytmmzcwjwxyywzzkybzcccttqnhx"
"nwxxkhkfhtswoccjybcmpzzykbnnzpbthhjdlszddytyfjpxyngfxbyqxzbhxcpxxtnzdnnycnxsxlhkmzxlthdhkghxxsshqyhh"
"cjyxglhzxcxnhekdtgqxqypkdhentykcnymyyjmkqyyyjxzlthhqtbyqhxbmyhsqckwwyllhcyylnneqxqwmcfbdccmljggxdqkt"
"lxkknqcdgcjwyjjlyhhqyttnwchhxcxwherzjydjccdbqcdgdnyxzdhcqrxcbhztqcbxwgqwyybxhmbymykdyecmqkyaqyngyzsl"
"fnkkqgyssqyshngjctxkzycssbkyxhyylstycxqthysmnscpmmgcccccmnztasmgqzjhklosjylswtmqzyqkdzljqqyplzycztcq"
"qpbbcjzclpkhqcyyxxdtdddsjcxffllchqxmjlwcjcxtspycxndtjshjwhdqqqckxyamylsjhmlalygxcyydmamdqmlmcznnyybz"
"xkyflmcncmlhxrcjjhsylnmtjggzgywjxsrxcwjgjqhqzdqjdcjjskjkgdzcgjjyjylxzxxcdqhhheslmhlfsbdjsyyshfyssczq"
"lpbdrfnztzdkykhsccgkwtqzckmsynbcrxqbjyfaxpzzedzcjykbcjwhyjbqzzywnyszptdkzpfpbaztklqnhbbzptpptyzzybhn"
"ydcpzmmcycqmcjfzzdcmnlfpbplngqjtbttajzpzbbdnjkljqylnbzqhksjznggqstzkcxchpzsnbcgzkddzqanzgjkdrtlzldwj"
"njzlywtxndjzjhxnatncbgtzcsskmljpjytsnwxcfjwjjtkhtzplbhsnjssyjbhbjyzlstlsbjhdnwqpslmmfbjdwajyzccjtbnn"
"nzwxxcdslqgdsdpdzgjtqqpsqlyyjzlgyhsdlctcbjtktyczjtqkbsjlgnnzdncsgpynjzjjyyknhrpwszxmtncszzyshbyhyzax"
"ywkcjtllckjjtjhgcssxyqyczbynnlwqcglzgjgqyqcczssbcrbcskydznxjsqgxssjmecnstjtpbdlthzwxqwqczexnqczgwesg"
"ssbybstscslccgbfsdqnzlccglllzghzcthcnmjgyzazcmsksstzmmzckbjygqljyjppldxrkzyxccsnhshhdznlzhzjjcddcbcj"
"xlbfqbczztpqdnnxljcthqzjgylklszzpcjdscqjhjqkdxgpbajynnsmjtzdxlcjyryynhjbngzjkmjxltbsllrzpylssznxjhll"
"hyllqqzqlsymrcncxsljmlzltzldwdjjllnzggqxppskyggggbfzbdkmwggcxmcgdxjmcjsdycabxjdlnbcddygskydqdxdjjyxh"
"saqazdzfslqxxjnqzylblxxwxqqzbjzlfbblylwdsljhxjyzjwtdjcyfqzqzzdzsxzzqlzcdzfxhwspynpqzmlpplffxjjnzzyls"
"jnyqzfpfzgsywjjjhrdjzzxtxxglghtdxcskyswmmtcwybazbjkshfhgcxmhfqhyxxyzftsjyzbxyxpzlchmzmbxhzzssyfdmncw"
"dabazlxktcshhxkxjjzjsthygxsxyyhhhjwxkzxssbzzwhhhcwtzzzpjxsyxqqjgzyzawllcwxznxgyxyhfmkhydwsqmnjnaycys"
"pmjkgwcqhylajgmzxhmmcnzhbhxclxdjpltxyjkdyylttxfqzhyxxsjbjnayrsmxyplckdnyhlxrlnllstycyyqygzhhsccsmcct"
"zcxhyqfpyyrpbflfqnntszlljmhwtcjqyzwtlnmlmdwmbzzsnzrbpdddlqjjbxtcsnzqqygwcsxfwzlxccrszdzmcyggdyqsgtnn"
"nlsmymmsyhfbjdgyxccpshxczcsbsjyygjmpbwaffyfnxhydxzylremzgzzyndsznlljcsqfnxxkptxzgxjjgbmyyssnbtylbnlh"
"bfzdcyfbmgqrrmzszxysjtznnydzzcdgnjafjbdknzblczszpsgcycjszlmnrznbzzldlnllysxsqzqlcxzlsgkbrxbrbzcycxzj"
"zeeyfgklzlnyhgzcgzlfjhgtgwkraajyzkzqtsshjjxdzyznynnzyrzdqqhgjzxsszbtkjbbfrtjxllfqwjgclqtymblpzdxtzag"
"bdhzzrbgjhwnjtjxlkscfsmwlldcysjtxkzscfwjlbnntzlljzllqblcqmqqcgcdfpbphzczjlpyyghdtgwdxfczqyyyqysrclqz"
"fklzzzgffcqnwglhjycjjczlqzzyjbjzzbpdcsnnjgxdqnknlznnnnpsntsdyfwwdjzjysxyyczcyhzwbbyhxrylybhkjksfxtjj"
"mmchhlltnyymsxxyzpdjjycsycwmdjjkqyrhllngpngtlyycljnnnxjyzfnmlrgjjtyzbsyzmsjyjhgfzqmsyxrszcytlrtqzsst"
"kxgqkgsptgxdnjsgcqcqhmxggztqydjjznlbznxqlhyqgggthqscbyhjhhkyygkggcmjdzllcclxqsftgjslllmlcskctbljszsz"
"mmnytpzsxqhjcnnqnyexzqzcpshkzzyzxxdfgmwqrllqxrfztlystctmjcsjjthjnxtnrztzfqrhcgllgcnnnnjdnlnnytsjtlny"
"xsszxcgjzyqpylfhdjsbbdczgjjjqzjqdybssllcmyttmqnbhjqmnygjyeqyqmzgcjkpdcnmyzgqllslnclmholzgdylfzslncnz"
"lylzcjeshnyllnxnjxlyjyyyxnbcljsswcqqnnyllzldjnllzllbnylnqchxyyqoxccqkyjxxxyklksxeyqhcqkkkkcsnyxxyqxy"
"gwtjohthxpxxhsnlcykychzzcbwqbbwjqcscszsslcylgddsjzmmymcytsdsxxscjpqqsqylyfzychdjynywcbtjsydchcyddjlb"
"djjsodzyqyskkyxdhhgqjyohdyxwgmmmazdybbbppbcmnnpnjzsmtxerxjmhqdntpjdcbsnmssythjtslmltrcplzszmlqdsdmjm"
"qpnqdxcfrnnfsdqqyxhyaykqyddlqyyysszbydslntfgtzqbzmchdhczcwfdxtmqqsphqwwxsrgjcwnntzcqmgwqjrjhtqjbbgwz"
"fxjhnqfxxqywyyhyscdydhhqmrmtmwctbszppzzglmzfollcfwhmmsjzttdhlmyffytzzgzyskjjxqyjzqbhmbzclyghgfmshpcf"
"zsnclpbqsnjyzslxxfpmtyjygbxlldlxpzjyzjyhhzcywhjylsjexfszzywxkzjlnadymlymqjpwxxhxsktqjezrpxxzghmhwqpw"
"qlyjjqjjzszcnhjlchhnxjlqwzjhbmzyxbdhhypylhlhlgfwlcfyytlhjjcwmscpxstkpnhjxsntyxxtestjctlsslstdlllwwyh"
"dnrjzsfgxssyczykwhtdhwjglhtzdqdjzxxqgghltzphcsqfclnjtclzpfstpdynylgmjllycqhynspchylhqyqtmzymbywrfqyk"
"jsyslzdnjmpxyyssrhzjnyqtqdfzbwwdwwrxcwggyhxmkmyyyhmxmzhnksepmlqqmtcwctmxmxjpjjhfxyyzsjzhtybmstsyjznq"
"jnytlhynbyqclcycnzwsmylknjxlggnnpjgtysylymzskttwlgsmzsylmpwlcwxwqcssyzsyxyrhssntsrwpccpwcmhdhhxzdzyf"
"jhgzttsbjhgyglzysmyclllxbtyxhbbzjkssdmalhhycfygmqypjyjqxjllljgclzgqlycjcctotyxmtmshllwlqfxymzmklpszz"
"cxhkjyclctyjcyhxsgyxnnxlzwpyjpxhjwpjpwxqqxlxsdhmrslzzydwdtcxknstzshbsccstplwsscjchjlcgchssphylhfhhxj"
"sxallnylmzdhzxylsxlmzykcldyahlcmddyspjtqjzlngjfsjshctsdszlblmssmnyymjqbjhrzwtyydchjljapzwbgqxbkfnbjd"
"llllyylsjydwhxpsbcmljpscgbhxlqhyrljxyswxhhzlldfhlnnymjljyflyjycdrjlfsyzfsllcqyqfgqyhnszlylmdtdjcnhbz"
"llnwlqxygyyhbmgdhxxnhlzzjzxczzzcyqzfngwpylcpkpykpmclgkdgxzgxwqbdxzzkzfbddlzxjtpjpttbythzzdwslcpnhslt"
"jxxqlhyxxxywzyswttzkhlxzxzpyhgzhknfsyhntjrnxfjcpjztwhplshfcrhnslxxjxxyhzqdxqwnnhyhmjdbflkhcxcwhjfyjc"
"fpqcxqxzyyyjygrpynscsnnnnchkzdyhflxxhjjbyzwttxnncyjjymswyxqrmhxzwfqsylznggbhyxnnbwttcsybhxxwxyhhxyxn"
"knyxmlywrnnqlxbbcljsylfsytjzyhyzawlhorjmnsczjxxxyxchcyqryxqzddsjfslyltsffyxlmtyjmnnyyyxltzcsxqclhzxl"
"wyxzhnnlrxkxjcdyhlbrlmbrdlaxksnlljlyxxlynrylcjtgncmtlzllcyzlpzpzyawnjjfybdyyzsepckzzqdqpbpsjpdyttbdb"
"bbyndycncpjmtmlrmfmmrwyfbsjgygsmdqqqztxmkqwgxllpjgzbqrdjjjfpkjkcxbljmswldtsjxldlppbxcwkcqqbfqbccajzg"
"mykbhyhhzykndqzybpjnspxthlfpnsygyjdbgxnhhjhzjhstrstldxskzysybmxjlxyslbzyslzxjhfybqnbylljqkygzmcyzzym"
"ccslnlhzhwfwyxzmwyxtynxjhbyymcysbmhysmydyshnyzchmjjmzcaahcbjbbhblytylsxsnxgjdhkxxtxxnbhnmlngsltxmrhn"
"lxqqxmzllyswqgdlbjhdcgjyqyymhwfmjybbbyjyjwjmdpwhxqldyapdfxxbcgjspckrssyzjmslbzzjfljjjlgxzgyxyxlszqkx"
"bexyxhgcxbpndyhwectwwcjmbtxchxyqqllxflyxlljlssnwdbzcmyjclwswdczpchqekcqbwlcgydblqppqzqfnqdjhymmcxtxd"
"rmzwrhxcjzylqxdyynhyyhrslnrsywwjjymtltllgtqcjzyabtckzcjyccqlysqxalmzynywlwdnzxqdllqshgpjfjljnjabcqzd"
"jgthhsstnyjfbswzlxjxrhgldlzrlzqzgsllllzlymxxgdzhgbdphzpbrlwnjqbpfdwonnnhlypcnjccndmbcpbzzncyqxldomzb"
"lzwpdwyygdstthcsqsccrsssyslfybnntyjszdfndpdhtqzmbqlxlcmyffgtjjqwftmnpjwdnlbzcmmcngbdzlqlpnfhyymjylsd"
"chdcjwjcctljcldtljjcbddpndsszycndbjlggjzxsxnlycybjjxxcbylzcfzppgkcxqdzfztjjfjdjxzbnzyjqctyjwhdyczhym"
"djxttmpxsplzcdwslshxypzgtfmlcjtacbbmgdewycyzxdszjyhflystygwhkjyylsjcxgywjcbllcsnddbtzbsclyzczzssqdll"
"mjyyhfllqllxfdyhabxggnywyypllsdldllbjcyxjznlhljdxyyqytdlllbngpfdfbbqbzzmdpjhgclgmjjpgaehhbwcqxajhhhz"
"chxyphjaxhlphjpgpzjqcqzgjjzzgzdmqyybzzphyhybwhazyjhykfgdpfqsdlzmljxjpgalxzdaglmdgxmmzqwtxdxxpfdmmssy"
"mpfmdmmkxksyzyshdzkjsysmmzzzmdydyzzczxbmlstmdyemxckjmztyymzmzzmsshhdccjewxxkljsthwlsqlyjzllsjssdppmh"
"nlgjczyhmxxhgncjmdhxtkgrmxfwmckmwkdcksxqmmmszzydkmsclcmpcjmhrpxqpzdsslcxkyxtwlkjyahzjgzjwcjnxyhmmbml"
"gjxmhlmlgmxctkzmjlyscjsyszhsyjzjcdajzhbsdqjzgwtkqxfkdmsdjlfmnhkzqkjfeypzyszcdpynffmzqykttdzzefmzlbnp"
"plplpbpszalltnlkckqzkgenjlwalkxydpxnhsxqnwqnkxqclhyxxmlnccwlymqyckynnlcjnszkpyzkcqzqljbdmdjhlasqlbyd"
"wqlwdgbqcryddztjybkbwszdxdtnpjdtcnqnfxqqmgnseclstbhpwslctxxlpwydzklnqgzcqapllkqcylbqmqczqcnjslqzdjxl"
"ddhpzqdljjxzqdjyzhhzlkcjqdwjppypqakjyrmpzbnmcxkllzllfqpylllmbsglzysslrsysqtmxyxzqzbscnysyztffmzzsmzq"
"hzssccmlyxwtpzgxzjgzgsjzgkddhtqggzllbjdzlsbzhyxyzhzfywxytymsdnzzyjgtcmtnxqyxjscxhslnndlrytzlryylxqht"
"xsrtzcgyxbnqqzfhykmzjbzymkbpnlyzpblmcnqyzzzsjztjctzhhyzzjrdyzhnfxklfzslkgjtctssyllgzrzbbjzzklpkbczys"
"nnyxbjfbnjzzxcdwlzyjxzzdjjgggrsnjkmsmzjlsjywqsnyhqjsxpjztnlsnshrnynjtwchglbnrjlzxwjqxqkysjycztlqzybb"
"ybyzjqdwgyzcytjcjxckcwdkkzxsnkdnywwyyjqyytlytdjlxwkcjnklccpzcqqdzzqlcsfqchqqgssmjzzllbjjzysjhtsjdysj"
"qjpdszcdchjkjzzlpycgmzndjxbsjzzsyzyhgxcpbjydssxdzncglqmbtsfcbfdzdlznfgfjgfsmpnjqlnblgqcyyxbqgdjjqsrf"
"kztjdhczklbsdzcfytplljgjhtxzcsszzxstjygkgckgynqxjplzbbbgcgyjzgczqszlbjlsjfzgkqqjcgycjbzqtldxrjnbsxxp"
"zshszycfwdsjjhxmfczpfzhqhqmqnknlyhtycgfrzgnqxcgpdlbzcsczqlljblhbdcypscppdymzzxgyhckcpzjgslzlnscnsldl"
"xbmsdlddfjmkdqdhslzxlsznpqpgjdlybdskgqlbzlnlkyyhzttmcjnqtzzfszqktlljtyyllnllqyzqlbdzlslyyzxmdfszsnxl"
"xznczqnbbwskrfbcylctnblgjpmczzlstlxshtzcyzlzbnfmqnlxflcjlyljqcbclzjgnsstbrmhxzhjzclxfnbgxgtqncztmsfz"
"kjmssncljkbhszjntnlzdntlmmjxgzjyjczxyhyhwrwwqnztnfjscpyshzjfyrdjsfscjzbjfzqzchzlxfxsbzqlzsgyftzdcszx"
"zjbjpszkjrhxjzcgbjkhcggtxkjqglxbxfgtrtylxqxhdtsjxhjzjjcmzlcqsbtxwqgxtxxhxftsdkfjhzyjfjxnzldlllcqsqqz"
"qwqxswqtwgwbzcgcllqzbclmqjtzgzyzxljfrmyzflxnsnxxjkxrmjdzdmmyxbsqbhgzmwfwygmjlzbyytgzyccdjyzxsngnyjyz"
"nbgpzjcqsyxsxrtfyzgrhztxszzthcbfclsyxzlzqmzlmplmxzjssfsbysmzqhxxnxrxhqzzzsslyflczjrcrxhhzxqndshxsjjh"
"qcjjbcynsysxjbqjpxzqplmlxzkyxlxcnlcycxxzzlxdlllmjyhzxhyjwkjrwyhcpsgnrzlfzwfzznsxgxflzsxzzzbfcsyjdbrj"
"krdhhjxjljjtgxjxxstjtjxlyxqfcsgswmsbctlqzzwlzzkxjmltmjyhsddbxgzhdlbmyjfrzfcgclyjbpmlysmsxlszjqqhjzfx"
"gfqfqbphngyyqxgztnqwyltlgwgwwhnlfmfgzjmgmgbgtjflyzzgzyzaflsspmlbflcwbjztljjmzlpjjlymqtmyyyfbgygqzgly"
"zdxqyxrqqqhsxyyqxygjtyxfsfsllgnqcygycwfhcccfxpylypllzqxxxxxqqhhsshjzcftsczjxspzwhhhhhapylqnlpqafyhxd"
"ylnkmzqgggddesrenzltzgchyppcsqjjhclljtolnjpzljlhymhezdydsqycddhgznndzclzywllznteydgnlhslpjjbdgwxpcnn"
"tycklkclwkllcasstknzdnnjttlyyzssysszzryljqkcgdhhyrxrzydgrgcwcgzqffbppjfzynakrgywyjpqxxfkjtszzxswzddf"
"bbqtbgtzkznpzfpzxzpjszbmqhkyyxyldkljnypkyghgdzjxxeaxpnznctzcmxcxmmjxnkszqnmnlwbwwqjjyhclstmcsxnjcxxt"
"pcnfdtnnpglllzcjlspblpgjcdtnjjlyarscffjfqwdpgzdwmrzzcgodaxnssnyzrestyjwjyjdbcfxnmwttbqlwstszgybljpxg"
"lbnclgpcbjftmxzljylzxcltpnclcgxtfzjshcrxsfysgdkntlbyjcyjllstgqcbxnhzxbxklylhzlqzlnzcqwgzlgzjncjgcmnz"
"zgjdzxtzjxycyycxxjyyxjjxsssjstsstdppghtcsxwzdcsynptfbchfbblzjclzzdbxgcjlhpxnfzflsyltnwbmnjhszbmdnbcy"
"sccldnycndqlyjjhmqllcsgljjsyfpyyccyltjantjjpwycmmgqyysxdxqmzhszxbftwwzqswqrfkjlzjqqyfbrxjhhfwjgzyqac"
"myfrhcyybynwlpexcczsyyrlttdmqlrkmpbgmyyjprkznbbsqyxbhyzdjdnghpmfsgbwfzmfqmmbzmzdcgjlnnnxyqgmlrygqccy"
"xzlwdkcjcggmcjjfyzzjhycfrrcmtznzxhkqgdjxccjeascrjthpljlrzdjrbcqhjdnrhylyqjsymhzydwcdfryhbbydtssccwbx"
"glpzmlzjdqsscfjmmxjcxjytycghycjwynsxlfemwjnmkllswtxhyyyncmmcyjdqdjzglljwjnkhpzggflccsczmcbltbhbqjxqd"
"jpdjztghglfjawbzyzjltstdhjhctcbchflqmpwdshyytqwcnntjtlnnmnndyyyxsqkxwyyflxxnzwcxypmaelyhgjwzzjbrxxaq"
"jfllpfhhhytzzxsgqjmhspgdzqwbwpjhzjdyjcqwxkthxsqlzyymysdzgnqckknjlwpnsyscsyzlnmhqsyljxbcxtlhzqzpcycyk"
"pppnsxfyzjjrcemhszmnxlxglrwgcstlrsxbygbzgnxcnlnjlclynymdxwtzpalcxpqjcjwtcyyjlblxbzlqmyljbghdslssdmxm"
"bdczsxyhamlczcpjmcnhjyjnsykchskqmczqdllkablwjqsfmocdxjrrlyqchjmybyqlrhetfjzfrfksryxfjdwtsxxywsqjysly"
"xwjhsdlxyyxhbhawhwjcxlmyljcsqlkydttxbzslfdxgxsjkhsxxybssxdpwncmrptqzczenygcxqfjxkjbdmljzmqqxnoxslyxx"
"lylljdzptymhbfsttqqwlhsgynlzzalzxclhtwrrqhlstmypyxjjxmnsjnnbryxyjllyqyltwylqyfmlkljdnlltfzwkzhljmlhl"
"jnljnnlqxylmbhhlnlzxqchxcfxxlhyhjjgbyzzkbxscqdjqdsndzsygzhhmgsxcsymxfepcqwwrbpyyjqryqcyjhqqzyhmwffhg"
"zfrjfcdbxntqyzpcyhhjlfrzgpbxzdbbgrqstlgdgylcqmgchhmfywlzyxkjlypjhsywmqqggzmnzjnsqxlqsyjtcbehsxfszfxz"
"wfllbcyyjdytdthwzsfjmqqyjlmqsxlldttkghybfpwdyysqqrnqwlgwdebzwcyygcnlkjxtmxmyjsxhybrwfymwfrxyymxysctz"
"ztfykmldhqdlgyjnlcryjtlpsxxxywlsbrrjwxhqybhtydnhhxmmywytycnnmnssccdalwztcpqpyjllqzyjswjwzzmmglmxclmx"
"nzmxmzsqtzppjqblpgxjzhfljjhycjsrxwcxsncdlxsyjdcqzxslqyclzxlzzxmxqrjmhrhzjbhmfljlmlclqnldxzlllfyprgjy"
"nxcqqdcmqjzzxhnpnxzmemmsxykynlxsxtljxyhwdcwdzhqyybgybcyscfgfsjnzdrzzxqxrzrqjjymcanhrjtldbpyzbstjhxxz"
"ypbdwfgzzrpymnnkxcqbyxnbnfyckrjjcmjegrzgyclnnzdnkknsjkcljspgyyclqqjybzssqlllkjftbgtylcccdblsppfylgyd"
"tzjqjzgkntsfcxbdkdxxhybbfytyhbclnnytgdhryrnjsbtcsnyjqhklllzslydxxwbcjqsbxnpjzjzjdzfbxxbrmladhcsnclbj"
"dstblprznswsbxbcllxxlzdnzsjpynyxxyftnnfbhjjjgbygjpmmmmsszljmtlyzjxswxtyledqpjmpgqzjgdjlqjwjqllsdgjgy"
"gmscljjxdtygjqjjjcjzcjgdzdshqgzjggcjhqxsnjlzzbxhsgzxcxyljxyxyydfqqjhjfxdhctxjyrxysqtjxyefyyssyxjxncy"
"zxfxcsxszxyyschshxzzzgzzzgfjdldylnpzgsjaztyqzpbxcbdztzczyxxyhhscjshcggqhjhgxhsctmzmehyxgebtclzkkwytj"
"zrslekestdbcyhqqsayxcjxwwgsphjszsdncsjkqcxswxfctynydpccczjqtcwjqjzzzqzljzhlsbhpydxpsxshhezdxfptjqyzc"
"xhyaxncfzyyhxgnqmywntzsjbnhhgymxmxqcnssbcqsjyxxtyyhybcqlmmszmjzzllcogxzaajzyhjmchhcxzsxsdznleyjjzjbh"
"zwjzsqtzpsxzzdsqjjjlnyazphhyysrnqzthzhnyjyjhdzxzlswclybzyecwcycrylchzhzydzydyjdfrjjhtrsqtxyxjrjhojyn"
"xelxsfsfjzghpzsxzszdzcqzbyyklsgsjhczshdgqgxyzgxchxzjwyqwgyhksseqzzndzfkwyssdclzstsymcdhjxxyweyxczayd"
"mpxmdsxybsqmjmzjmtjqlpjyqzcgqhyjhhhqxhlhdldjqcfdwbsxfzzyyschtytyjbhecxhjkgqfxbhyzjfxhwhbdzfyzbchpnpg"
"dydmsxhkhhmamlnbyjtmpxejmcthqbzyfcgtyhwphftgzzezsbzegpbmdskftycmhbllhgpzjxzjgzjyxzsbbqsczzlzscstpgxm"
"jsfdcczjzdjxsybzlfcjsazfgszlwbczzzbyztzynswyjgxzbdsynxlgzbzfygczxbzhzftpbgzgejbstgkdmfhyzzjhzllzzgjq"
"zlsfdjsscbzgpdlfzfzszyzyzsygcxsnxxchczxtzzljfzgqsqqxcjqccccdjcdszzyqjccgxztdlgscxzsyjjqtcclqdqztqchq"
"qyzynzzzpbkhdjfcjfztypqyqttynlmbdktjcpqzjdzfpjsbnjlgyjdxjdcqkzgqkxclbzjtcjdqbxdjjjstcxnxbxqmslyjcxnt"
"jqwwcjjnjjlllhjcwqtbzqqczczpzzdzyddcyzdzccjgtjfzdprntctjdcxtqzdtjnplzbcllctdsxkjzqdmzlbznbtjdcxfczdb"
"czjjltqqpldckztbbzjcqdcjwynllzlzccdwllxwzlxrxntqjczxkjlsgdnqtddglnlajjtnnynkqlldzntdnycygjwyxdxfrsqs"
"tcdenqmrrqzhhqhdldazfkapbggpzrebzzykyqspeqjjglkqzzzjlysyhyzwfqznlzzlzhwcgkypqgnpgblplrrjyxcccgyhsfzf"
"wbzywtgzxyljczwhncjzplfflgskhyjdeyxhlpllllcygxdrzelrhgklzzyhzlyqszzjzqljzflnbhgwlczcfjwspyxzlzlxgccp"
"zbllcxbbbbnbbcbbcrnnzccnrbbnnldcgqyyqxygmqzwnzytyjhyfwtehznjywlccntzyjjcdedpwdztstnjhtymbjnyjzlxtsst"
"phndjxxbyxqtzqddtjtdyztgwscszqflshlnzbcjbhdlyzjyckwtydylbnydsdsycctyszyyebgexhqddwnygyclxtdcystqnygz"
"ascsszzdzlcclzrqxyywljsbymxshzdembbllyyllytdqyshymrqnkfkbfxnnsbychxbwjyhtqbpbsbwdzylkgzskyghqzjxhxjx"
"gnljkzlyycdxlfwfghljgjybxblybxqpqgntzplncybxdjyqydymrbeyjyyhkxxstmxrczzjwxyhybmcflyzhqyzfwxdbxbcwzms"
"lpdmyckfmzklzcyqycclhxfzlydqzpzygyjyzmdxtzfnnyttqtzhgsfcdmlccytzxjcytjmkslpzhysnwllytpzctzccktxdhxxt"
"qcyfksmqccyyazhtjplylzlyjbjxtfnyljyynrxcylmmnxjsmybcsysslzylljjgyldzdlqhfzzblfndsqkczfyhhgqmjdsxyctt"
"xnqnjpyybfcjtyyfbnxejdgyqbjrcnfyyqpghyjsyzngrhtknlnndzntsmgklbygbpyszbydjzsstjztsxzbhbscsbzczptqfzlq"
"flypybbjgszmnxdjmtsyskkbjtxhjcegbsmjyjzcstmljyxrczqscxxqpyzhmkyxxxjcljyrmyygadyskqlnadhrskqxzxztcggz"
"dlmlwxybwsyctbhjhcfcwzsxwwtgzlxqshnyczjxemplsrcgltnzntlzjcyjgdtclglbllqpjmzpapxyzlaktkdwczzbncctdqqz"
"qyjgmcdxltgcszlmlhbglkznnwzndxnhlnmkydlgxdtwcfrjerctzhydxykxhwfzcqshknmqqhzhhymjdjskhxzjzbzzxympajnm"
"ctbxlsxlzynwrtsqgscbptbsgzwyhtlkssswhzzlyytnxjgmjrnsnnnnlskztxgxlsammlbwldqhylakqcqctmycfjbslxclzjcl"
"xxknbnnzlhjphqplsxsckslnhpsfqcytxjjzljldtzjjzdlydjntptnndskjfsljhylzqqzlbthydgdjfdbyadxdzhzjnthqbykn"
"xjjqczmlljzkspldsclbblnnlelxjlbjycxjxgcnlcqplzlznjtsljgyzdzpltqcssfdmnycxgbtjdcznbgbqyqjwgkfhtnbyqzq"
"gbkpbbyzmtjdytblsqmbsxtbnpdxklemyycjynzdtldykzzxtdxhqshygmzsjycctayrzlpwltlkxslzcggexclfxlkjrtlqjaqz"
"ncmbqdkkcxglczjzxjhptdjjmzqykqsecqzdshhadmlzfmmzbgntjnnlhbyjbrbtmlbyjdzxlcjlpldlpcqdhlhzlycblcxccjad"
"qlmzmmsshmybhbnkkbhrsxxjmxmdznnpklbbrhgghfchgmnklltsyyycqlcskymyehywxnxqywbawykqldnntndkhqcgdqktgpkx"
"hcpdhtwnmssyhbwcrwxhjmkmzngwtmlkfghkjyldyycxwhyyclqhkqhtdqkhffldxqwytyydesbpkyrzpjfyyzjceqdzzdlattpb"
"fjllcxdlmjsdxegwgsjqxcfbssszpdyzcxznyxppzydlyjccpltxlnxyzyrscyyytylwwndsahjsygyhgywwaxtjzdaxysrltdps"
"syxfnejdxyzhlxlllzhzsjnyqyqyxyjghzgjcyjchzlycdshhsgczyjscllnxzjjyyxnfsmwfpyllyllabmddhwzxjmcxztzpmlq"
"chsfwzynctlndywlslxhymmylmbwwkyxyaddxylldjpybpwnxjmmmllhafdllaflbnhhbqqjqzjcqjjdjtffkmmmpythygdrjrdd"
"wrqjxnbysrmzdbyytbjhpymyjtjxaahggdqtmystqxkbtzbkjlxrbyqqhxmjjbdjntgtbxpgbktlgqxjjjcdhxqdwjlwrfmjgwqh"
"cnrxswgbtgygbwhswdwrfhwytjjxxxjyzyslphyypyyxhydqpxshxyxgskqhywbdddpplcjlhqeewjgsyykdpplfjthkjltcyjhh"
"jttpltzzcdlyhqkcjqysteeyhkyzyxxyysddjkllpymqyhqgxqhzrhbxpllnqydqhxsxxwgdqbshyllpjjjthyjkyphthyyktyez"
"yenmdshlzrpqfbnfxzbsftlgxsjbswyysksflxlpplbbblnsfbfyzbsjssylpbbffffsscjdstjsxtryjcyffsyzyzbjtlctsbsd"
"hrtjjbytcxyyeylycbnebjdsysyhgsjzbxbytfzwgenhhhthjhhxfwgcstbgxklstyymtmbyxjskzscdyjrcythxzfhmymcxlzns"
"djtxtxrycfyjsbsdyerxhljxbbdeynjghxgckgscymblxjmsznskgxfbnbbthfjyafxwxfbxmyfhdttcxzzpxrsywzdlybbktyqw"
"qjbzypzjznjpzjlztfysbttslmptzrtdxqsjehbnylndxljsqmlhtxtjecxalzzspktlzkqqyfsyjywpcpqfhjhytqxzkrsgtksq"
"czlptxcdyyzsslzslxlzmacpcqbzyxhbsxlzdltztjtylzjyytbzypltxjsjxhlbmytxcqrblzssfjzztnjytxmyjhlhpblcyxqj"
"qqkzzscpzkswalqsplczzjsxgwwwygyatjbbctdkhqhkgtgpbkqyslbxbbckbmllndzstbklggqkqlzbkktfxrmdkbftpzfrtppm"
"ferqnxgjpzsstlbztpszqzsjdhljqlzbpmsmmsxlqqnhknblrddnhxdkddjcyyljfqgzlgsygmjqjkhbpmxyxlytqwlwjcpbmjxc"
"yzydrjbhtdjyeqshtmgsfyplwhlzffnynnhxqhpltbqpfbjwjdbygpnxtbfzjgnnntjshxeawtzylltyqbwjpgxghnnkndjtmszs"
"qynzggnwqtfhclssgmnnnnynzqqxncjdqgzdlfnykljcjllzlmzznnnnsshthxjlzjbbhqjwwycrdhlyqqjbeyfsjhthnrnwjhwp"
"slmssgzttygrqqwrnlalhmjtqjsmxqbjjzjqzyzkxbjqxbjxshzssfglxmxnxfghkzszggslcnnarjxhnlllmzxelglxydjytlfb"
"kbpnlyzfbbhptgjkwetzhkjjxzxxglljlstgshjjyqlqzfkcgnndjsszfdbctwwseqfhqjbsaqtgypjlbxbmmywxgslzhglsgnyf"
"ljbyfdjfngsfmbyzhqffwjsyfyjjphzbyyzffwotjnlmftwlbzgyzqxcdjygzyyryzynyzwegazyhjjlzrthlrmgrjxzclnnnljj"
"yhtbwjybxxbxjjtjteekhwslnnlbsfazpqqbdlqjjtyyqlyzkdksqjnejzldqcgjqnnjsncmrfqthtejmfctyhypymhydmjncfgy"
"yxwshctxrljgjzhzcyyyjltkttntmjlzclzzayyoczlrlbszywjytsjyhbyshfjlykjxxtmzyyltxxypslqyjzyzyypnhmymdyyl"
"blhlsyygqllnjjymsoycbzgdlyxylcqyxtszegxhzglhwbljheyxtwqmakbpqcgyshhegqcmwyywljyjhyyzlljjylhzyhmgsljl"
"jxcjjyclycjbcpzjzjmmwlcjlnqljjjlxyjmlszljqlycmmgcfmmfpqqmfxlqmcffqmmmmhnznfhhjgtthxkhslnchhyqzxtmmqd"
"cydyxyqmyqylddcyaytazdcymdydlzfffmmycqcwzzmabtbyctdmndzggdftypcgqyttssffwbdttqssystwnjhjytsxxylbyyhh"
"whxgzxwznnqzjzjjqjccchykxbzszcnjtllcqxynjnckycynccqnxyewyczdcjycchyjlbtzyycqwlpgpyllgktltlgkgqbgychj"
"xy";

char pinyinFirstLetter(unsigned short hanzi){
    
    int index = hanzi - HANZI_START;
    
    if (index >= 0 && index <= HANZI_COUNT){
        
        return firstLetterArray[index];
        
    }else{
        
        return '#';
        
    }
}
/**
 *  unicode转码成中文
 */
NSString *UTF8StringByReplaceUnicodeString(NSString *unicodeString){
    
    NSMutableString *convertedString = [unicodeString mutableCopy];
    [convertedString replaceOccurrencesOfString:@"\\U" withString:@"\\u" options:0 range:NSMakeRange(0, convertedString.length)];
    CFStringRef transform = CFSTR("Any-Hex/Java");
    CFStringTransform((__bridge CFMutableStringRef)convertedString, NULL, transform, YES);
    return convertedString;
}

@implementation NSArray (Log)

- (NSString *)descriptionWithLocale:(id)locale
{
    for (id object in self) {
        
        if (![object isKindOfClass:[NSDictionary class]]&&![object isKindOfClass:[NSArray class]] && ![object isKindOfClass:[NSString class]]) {
            return [self wwz_array_description];
        }
    }
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:self options:kNilOptions error:&error];
    
    if (!error && data.length>0) {
        
        return [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] wwz_jsonFormat];
        
    }else{
        
        return [self wwz_array_description];
    }
}
- (NSString *)wwz_array_description
{
    NSMutableString *strM = [NSMutableString stringWithString:@"[\n"];
    
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [strM appendFormat:@"\t%@,\n", obj];
    }];
    
    [strM appendString:@"]"];
    
    return strM;
}

#pragma mark - 交换方法实现

+ (void)load {
    method_exchangeImplementations(class_getInstanceMethod([self class], @selector(description)), class_getInstanceMethod([self class], @selector(wwz_description)));
    method_exchangeImplementations(class_getInstanceMethod([self class], @selector(descriptionWithLocale:)), class_getInstanceMethod([self class], @selector(wwz_descriptionWithLocale:)));
    method_exchangeImplementations(class_getInstanceMethod([self class], @selector(descriptionWithLocale:indent:)), class_getInstanceMethod([self class], @selector(wwz_descriptionWithLocale:indent:)));
}

- (NSString *)wwz_description{
    
    return UTF8StringByReplaceUnicodeString([self wwz_description]);
}

- (NSString *)wwz_descriptionWithLocale:(id)locale{
    
    return UTF8StringByReplaceUnicodeString([self wwz_descriptionWithLocale:locale]);
}

- (NSString *)wwz_descriptionWithLocale:(id)locale indent:(NSUInteger)level{
    
    return UTF8StringByReplaceUnicodeString([self wwz_descriptionWithLocale:locale indent:level]);
}
@end

@implementation NSDictionary (Log)

- (NSString *)descriptionWithLocale:(id)locale
{
    if ([self isKindOfClass:NSClassFromString(@"__NSCFDictionary")]) {
        
        return [self wwz_dictionary_description];
    }
    
    __block BOOL isStop = NO;
    
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL * stop) {
        
        if (![key isKindOfClass:[NSString class]]) {
            
            isStop = stop = YES;
        }
        if (![obj isKindOfClass:[NSDictionary class]]&&![obj isKindOfClass:[NSArray class]] && ![obj isKindOfClass:[NSString class]]) {
            
            isStop = stop = YES;
        }
    }];
    
    if (isStop) {
        return [self wwz_dictionary_description];
    }
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:self options:kNilOptions error:&error];
    
    if (!error && data.length>0) {
        
        return [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] wwz_jsonFormat];
        
    }else{
        
        return [self wwz_dictionary_description];
    }
}

- (NSString *)wwz_dictionary_description{
    
    NSMutableString *strM = [NSMutableString stringWithString:@"{\n"];
    
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [strM appendFormat:@"\t%@ = %@;\n", key, obj];
    }];
    
    [strM appendString:@"}\n"];
    
    return strM;
}


#pragma mark - 交换方法实现

+ (void)load {
    method_exchangeImplementations(class_getInstanceMethod([self class], @selector(description)), class_getInstanceMethod([self class], @selector(wwz_description)));
    method_exchangeImplementations(class_getInstanceMethod([self class], @selector(descriptionWithLocale:)), class_getInstanceMethod([self class], @selector(wwz_descriptionWithLocale:)));
    method_exchangeImplementations(class_getInstanceMethod([self class], @selector(descriptionWithLocale:indent:)), class_getInstanceMethod([self class], @selector(wwz_descriptionWithLocale:indent:)));
}

- (NSString *)wwz_description{
    
    return UTF8StringByReplaceUnicodeString([self wwz_description]);
}

- (NSString *)wwz_descriptionWithLocale:(id)locale{
    
    return UTF8StringByReplaceUnicodeString([self wwz_descriptionWithLocale:locale]);
}

- (NSString *)wwz_descriptionWithLocale:(id)locale indent:(NSUInteger)level{
    
    return UTF8StringByReplaceUnicodeString([self wwz_descriptionWithLocale:locale indent:level]);
}

@end

@implementation NSString (Log)

#pragma mark - 交换方法实现

+ (void)load {
    method_exchangeImplementations(class_getInstanceMethod([self class], @selector(description)), class_getInstanceMethod([self class], @selector(wwz_description)));
    method_exchangeImplementations(class_getInstanceMethod([self class], @selector(descriptionWithLocale:)), class_getInstanceMethod([self class], @selector(wwz_descriptionWithLocale:)));
    method_exchangeImplementations(class_getInstanceMethod([self class], @selector(descriptionWithLocale:indent:)), class_getInstanceMethod([self class], @selector(wwz_descriptionWithLocale:indent:)));
}

- (NSString *)wwz_description{
    
    return UTF8StringByReplaceUnicodeString([self wwz_description]);
}

- (NSString *)wwz_descriptionWithLocale:(id)locale{
    
    return UTF8StringByReplaceUnicodeString([self wwz_descriptionWithLocale:locale]);
}

- (NSString *)wwz_descriptionWithLocale:(id)locale indent:(NSUInteger)level{
    
    return UTF8StringByReplaceUnicodeString([self wwz_descriptionWithLocale:locale indent:level]);
}

@end

@implementation NSString (WZJson)

/**
 *  json字符串格式化
 */
- (NSString *)wwz_jsonFormat{
    
    NSString *spacing = @"\t";
    NSString *enterKey = @"\n";
    
    int number = 0;
    
    // 添加空格block
    NSString *(^addSpaceBlock)(int) = ^NSString *(int num){
        NSMutableString *mString = [NSMutableString string];
        for (int i = 0; i < num; i++) {
            [mString appendString:spacing];
        }
        return mString;
    };
    
    NSMutableString *mString = [NSMutableString stringWithFormat:@"%@", enterKey];
    
    // 第一个字符
    NSString *firstCharacter = [self substringWithRange:NSMakeRange(0, 1)];
    // 打印：当前字符。
    [mString appendString:firstCharacter];
    
    if ([firstCharacter isEqualToString:@"["] || [firstCharacter isEqualToString:@"{"]) {
        
        //（3）前方括号、前花括号，的后面必须换行。打印：换行。
        [mString appendString:enterKey];
        
        //（4）每出现一次前方括号、前花括号；缩进次数增加一次。打印：新行缩进。
        number++;
        [mString appendString:addSpaceBlock(number)];
    }
    
    // 是否在引号内
    BOOL isInQuotation = NO;
    //遍历输入字符串。
    for (int i = 1; i < self.length; i++) {
        
        //1、获取当前字符。
        NSString *subCharacter = [self substringWithRange:NSMakeRange(i, 1)];
        
        // 如果是":",反转isInColon
        if ([subCharacter isEqualToString:@"\""]&&![[self substringWithRange:NSMakeRange(i-1, 1)] isEqualToString:@"\\"]) {
            
            isInQuotation = !isInQuotation;
        }
        
        if (isInQuotation) {// 当前字符处于引号内
            
            //（2）打印：当前字符。
            [mString appendString:subCharacter];
            continue;
        }
        //2、如果当前字符是前方括号、前花括号做如下处理：
        if ([subCharacter isEqualToString:@"["] || [subCharacter isEqualToString:@"{"]) {
            
            // (1）如果前面还有字符，前面字符为“：”，打印：换行和缩进字符字符串
            if ([[self substringWithRange:NSMakeRange(i-1, 1)] isEqualToString:@":"]) {
                
                [mString appendString:enterKey];
                [mString appendString:addSpaceBlock(number)];
            }
            //（2）打印：当前字符。
            [mString appendString:subCharacter];
            
            //（3）前方括号、前花括号，的后面必须换行。打印：换行。
            [mString appendString:enterKey];
            
            //（4）每出现一次前方括号、前花括号；缩进次数增加一次。打印：新行缩进。
            number++;
            [mString appendString:addSpaceBlock(number)];
            
        }else if ([subCharacter isEqualToString:@"]"]||[subCharacter isEqualToString:@"}"]) {//3、如果当前字符是后方括号、后花括号做如下处理：
            
            //（1）后方括号、后花括号，的前面必须换行。打印：换行。
            [mString appendString:enterKey];
            //（2）每出现一次后方括号、后花括号；缩进次数减少一次。打印：缩进。
            number--;
            [mString appendString:addSpaceBlock(number)];
            //（3）打印：当前字符。
            [mString appendString:subCharacter];
            //（4）如果当前字符后面还有字符，并且字符不为“，”，打印：换行。
            if (((i+1)<self.length) && ![[self substringWithRange:NSMakeRange(i+1, 1)] isEqualToString:@","]) {
                
                [mString appendString:enterKey];
            }
        }else if ([subCharacter isEqualToString:@","]) {//4、如果当前字符是逗号。逗号后面换行，并缩进，不改变缩进次数。
            
            [mString appendString:subCharacter];
            [mString appendString:enterKey];
            [mString appendString:addSpaceBlock(number)];
            
        }else{// 其它正常打印
            [mString appendString:subCharacter];
        }
    }
    return mString;
    
}

@end

@implementation NSString (PinYin)

/**
 *  得到文本首字的大写字母
 */
+ (NSString *)wwz_firstUpperLetterWithString:(NSString *)string{
    if (!string||string.length == 0) {
        return nil;
    }
    char firstS = '0';
    if ([self wwz_isChinesecharacterWithString:string]) {
        firstS = pinyinFirstLetter([string characterAtIndex:0]);
    }else{
        firstS = [string characterAtIndex:0];
    }
    return [[NSString stringWithFormat:@"%c", firstS] uppercaseString];
}
/**
 *  首字是否为汉字
 */
+ (BOOL)wwz_isChinesecharacterWithString:(NSString *)string{
    if (!string||string.length == 0) {
        return NO;
    }
    unichar c = [string characterAtIndex:0];
    if (c >=0x4E00 && c <=0x9FA5){
        return YES;//汉字
    }else{
        return NO;//英文
    }
}

/**
 *  包含数字和字母
 */
+ (BOOL)wwz_isContainNumberAndCharacterWithString:(NSString *)string{
    const char *buffer = [string UTF8String];
    BOOL isContainNumber = NO;
    BOOL isContainCharacter = NO;
    for (int i = 0; i < strlen(buffer); i++) {
        char ch = buffer[i];
        if ([self isNumberWithCh:ch]) {
            isContainNumber = YES;
        }else if([self isCharacterWithCh:ch]){
            isContainCharacter = YES;
        }
    }
    if (isContainCharacter && isContainNumber) {
        return YES;
    }
    return NO;
}
+ (BOOL)isNumberWithCh:(char)ch{
    if (ch >= '0' && ch <= '9') {
        return YES;
    }
    return NO;
}
+ (BOOL)isCharacterWithCh:(char)ch{
    if ((ch >= 'a' && ch <= 'z')||(ch >= 'A' && ch <= 'Z')) {
        return YES;
    }
    return NO;
}


/**
 *  计算汉字的个数
 */
+ (NSInteger)wwz_chineseCountOfString:(NSString *)string{
    if (!string||string.length == 0) {
        return 0;
    }
    int chineseCount = 0;
    
    for (int i = 0; i<string.length; i++) {
        unichar c = [string characterAtIndex:i];
        if (c >=0x4E00 && c <=0x9FA5){
            chineseCount++ ;//汉字
        }
    }
    return chineseCount;
}

/**
 *  计算非汉字的个数
 */
+ (NSInteger)wwz_characterCountOfString:(NSString *)string{
    
    if (!string||string.length == 0) {
        return 0;
    }
    int characterCount = 0;
    for (int i = 0; i<string.length; i++) {
        unichar c = [string characterAtIndex:i];
        if (c >=0x4E00 && c <=0x9FA5){
            
        }else{
            characterCount++;//英文
        }
    }
    return characterCount;
}

@end

@implementation NSString (Handle)

/**
 *  NSDocumentDirectory 中文件路径
 */
+ (NSString *)wwz_filePathWithFileName:(NSString *)fileName{
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath = [documentPath stringByAppendingPathComponent:fileName];
    return filePath;
}

/**
 *  MD5加密
 */
- (NSString *)wwz_md5String{
    
    const char *string = self.UTF8String;
    int length = (int)strlen(string);
    unsigned char bytes[CC_MD5_DIGEST_LENGTH];
    CC_MD5(string, length, bytes);
    return [self stringFromBytes:bytes length:CC_MD5_DIGEST_LENGTH];
}

- (NSString *)stringFromBytes:(unsigned char *)bytes length:(NSUInteger)length{
    
    NSMutableString *mutableString = @"".mutableCopy;
    for (int i = 0; i < length; i++)
        [mutableString appendFormat:@"%02x", bytes[i]];
    return [NSString stringWithString:mutableString];
}
/**
 *  指定长度字符串（从后面截取）
 *
 *  @param length 截取长度
 *
 *  @return 指定长度字符串，不足前面补0
 */
- (NSString *)wwz_fixedStringWithLength:(NSUInteger)length{
    
    if (self.length>=length) {
        
        return [self substringFromIndex:self.length-length];
        
    }else{
        
        NSString *string = [NSString stringWithFormat:@"%@",self];
        for (int i = 0; i<length-self.length; i++) {
            string = [NSString stringWithFormat:@"0%@", string];
        }
        return string;
    }
}
/**
 *  字符串截取中间
 *
 *  @param range range
 *
 *  @return 截取后字符串，越界返回nil
 */
- (NSString *)wwz_substringWithRange:(NSRange)range{
    
    if (self.length < range.location+range.length) {
        return nil;
    }
    
    return [self substringWithRange:range];
}

/**
 *  拆分字符串
 *
 *  @param string 拆分字符
 *
 *  @return 拆分后的数组，不含拆分字符返回@[self]
 */
- (NSArray *)wwz_componentsSeparatedByString:(NSString *)string{
    
    if ([self rangeOfString:string].length == 0) {
        return @[self];
    }
    return [self componentsSeparatedByString:string];
}
/**
 *  十六进制字符串每两位相加
 */
- (NSString *)wwz_stringByAddPerTwoNumber{
    int allCount = 0;
    for (int i = 0; i <= self.length-2; i+=2) {
        allCount += [[self substringWithRange:NSMakeRange(i, 2)] wwz_tenTypeValue];
    }
    return [NSString stringWithFormat:@"%d",allCount];
}

#pragma mark - 进制转换

/**
 *  得到十六进制字符
 */
- (NSString *)wwz_sixteenthTypeString{
    
    return [NSString stringWithFormat:@"%x", [self intValue]];
}
/**
 *  十六进制字符转十进制数
 */
- (long)wwz_tenTypeValue{
    
    return (long)strtoul([self UTF8String], 0, 16);
}

/**
 *  格式化为16进制2位字符串
 *
 *  @param number 10进制int
 *
 *  @return 16进制
 */
+ (NSString *)wwz_formatSisteenCmdWithDecimalNumber:(long)number{
    return [[[NSString stringWithFormat:@"%ld", number] wwz_sixteenthTypeString] wwz_fixedStringWithLength:2];
}

@end


@implementation NSString (Conversion)


#pragma mark - 进制转换

/**
 *  十六进制 ==> 十进制数
 *
 *  @param sixteenString 十六进制
 *
 *  @return 十进制数
 */
+ (unsigned long)wwz_decimalNumberFromSixteenString:(NSString *)sixteenString{
    
    return strtoul([sixteenString UTF8String], 0, 16);
}

/**
 *  十进制 ==> 十六进制
 *
 *  @param decimalString 十进制
 *
 *  @return 十六进制
 */
+ (NSString *)wwz_sixteenStringFromDecimalString:(NSString *)decimalString{
    
    return [NSString stringWithFormat:@"%x", [decimalString intValue]];
}

/**
 *  十进制转二进制
 */
+ (NSString *)wwz_binaryStringFromDecimalString:(NSString *)decimalString{
    
    int tmpid = [decimalString intValue];
    NSString *binary = @"";
    
    while (tmpid){
        
        binary = [[NSString stringWithFormat:@"%d",tmpid%2] stringByAppendingString:binary];
        
        if (tmpid/2 < 1) break;
        
        tmpid = tmpid/2 ;
    }
    return binary;
}

/**
 *  二进制转十进制
 */
+ (NSString *)wwz_decimalStringFromBinaryString:(NSString *)binaryString{
    
    int ll = 0 ;
    int  temp = 0 ;
    for (int i = 0; i < binaryString.length; i ++){
        
        temp = [[binaryString substringWithRange:NSMakeRange(i, 1)] intValue];
        temp = temp * powf(2, binaryString.length - i - 1);
        ll += temp;
    }
    return [NSString stringWithFormat:@"%d",ll];
}

/**
 *  十六进制转二进制
 *
 *  @param sixteenString 十六进制
 *
 *  @return 二进制
 */
+ (NSString *)wwz_binaryStringFromSixteenString:(NSString *)sixteenString{
    
    NSString *decimalString = [NSString stringWithFormat:@"%ld",[self wwz_decimalNumberFromSixteenString:sixteenString]];
    
    return [self wwz_binaryStringFromDecimalString:decimalString];
}

/**
 *  二进制转十六进制
 *
 *  @param binaryString 二进制
 *
 *  @return 十六进制
 */
+ (NSString *)wwz_sixteenStringFromBinaryString:(NSString *)binaryString{
    
    NSString *decimalString = [self wwz_decimalStringFromBinaryString:binaryString];
    
    return [self wwz_sixteenStringFromDecimalString:decimalString];
}

/**
 *  将二进制数据流转换成十六进制字符串
 *
 *  @param data 二进制数据
 *
 *  @return 十六进制字符串
 */
+ (NSString *)wwz_data2Hex:(NSData *)data {
    if (!data) {
        return nil;
    }
    Byte *bytes = (Byte *)[data bytes];
    NSMutableString *str = [NSMutableString stringWithCapacity:data.length * 2];
    for (int i=0; i < data.length; i++){
        [str appendFormat:@"%0x", bytes[i]];
    }
    return str;
}

/**
 *  返回转换后的值,只能转换2,8,16进制(没测试过)
 *
 *  @param str 需要转换的值
 *  @param sys 需要转换的进制
 *
 *  @return 转换后的值
 */
+ (NSString *)wwz_transformString:(NSString *)fromString toNumberSystem:(NSInteger)sysNumber{
    
    NSMutableString *mString = [NSMutableString stringWithFormat:@"X"];
    
    NSString *bitString = [NSString stringWithFormat:@"0123456789ABCDEF"];
    
    NSInteger tmp = [fromString intValue], p, a, b;
    
    if(sysNumber ==2){
        a = 1;
        b = 1;
    }else if (sysNumber == 8){
        a = 7;
        b = 3;
    }else if (sysNumber == 16){
        a = 15;
        b = 4;
    }else{
        NSLog(@"您输入的进制错误!请输入2,8,16进制!");
        return nil;
    }
    while(tmp!=0){
        
        p=tmp&a;
        
        NSString *str1=[NSString stringWithFormat:@"%c",[bitString characterAtIndex:p]];
        [mString insertString:str1 atIndex:0];
        
        tmp=tmp>>b;
    }
    
    return [mString substringWithRange:NSMakeRange(0, [mString length]-1)];
}

#pragma mark - Hex

/**
 *  十六进制字符串 ==> 普通字符串
 *
 *  @param hexString 十六进制字符串
 *
 *  @return 普通字符串
 */
+ (NSString *)wwz_normalStringFromHexString:(NSString *)hexString{
    
    if (!hexString) {
        return nil;
    }
    
    if (hexString.length == 0) {
        return @"";
    }
    
    char *myBuffer = (char *)malloc((int)[hexString length] / 2 + 1);
    
    bzero(myBuffer, [hexString length] / 2 + 1);
    
    for (int i = 0; i < hexString.length - 1; i += 2) {
        
        unsigned int anInt;
        
        NSString *hexCharStr = [hexString substringWithRange:NSMakeRange(i, 2)];
        
        NSScanner *scanner = [[NSScanner alloc] initWithString:hexCharStr];
        
        [scanner scanHexInt:&anInt];
        
        myBuffer[i / 2] = (char)anInt;
    }
    return [NSString stringWithCString:myBuffer encoding:NSUTF8StringEncoding];
}

/**
 *  普通字符串 ==> 十六进制字符串
 *
 *  @param normalString 普通字符串
 *
 *  @return 十六进制字符串
 */
+ (NSString *)wwz_hexStringFromNormalString:(NSString *)normalString{
    
    return [self wwz_hexStringFromData:[normalString dataUsingEncoding:NSUTF8StringEncoding]];
}

/**
 *  NSData ==> 十六进制的字符串
 *
 *  @param data NSData
 *
 *  @return 十六进制的字符串
 */
+ (NSString *)wwz_hexStringFromData:(NSData *)data{
    
    if (!data) {
        return nil;
    }
    
    if (data.length == 0) {
        return @"";
    }
    
    Byte *bytes = (Byte *)[data bytes];
    
    NSString *hexStr=@"";
    
    for(int i=0;i<[data length];i++){
        
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数
        
        if([newHexStr length]==1){
            
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
            
        }else{
            
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
        }
    }
    return hexStr;
}

/**
 *  十六进制的字符串 ==> Byte 数组 ==> NSData
 *
 *  @return NSData
 */
+ (NSData *)wwz_byteDataFromHexString:(NSString *)hexString{
    
    if (!hexString) {
        return nil;
    }
    
    int j=0;
    
    Byte bytes[128];  ///3ds key的Byte 数组， 128位
    
    for(int i=0;i<[hexString length];i++){
        
        int int_ch;  /// 两位16进制数转化后的10进制数
        
        unichar hex_char1 = [hexString characterAtIndex:i]; ////两位16进制数中的第一位(高位*16)
        
        int int_ch1;
        
        if(hex_char1 >= '0' && hex_char1 <='9'){
            
            int_ch1 = (hex_char1-48)*16;   //// 0 的Ascll - 48
            
        }else if(hex_char1 >= 'A' && hex_char1 <='F'){
            
            int_ch1 = (hex_char1-55)*16; //// A 的Ascll - 65
            
        }else{
            
            int_ch1 = (hex_char1-87)*16; //// a 的Ascll - 97
        }
        i++;
        
        unichar hex_char2 = [hexString characterAtIndex:i]; ///两位16进制数中的第二位(低位)
        
        int int_ch2;
        
        if(hex_char2 >= '0' && hex_char2 <='9'){
            
            int_ch2 = (hex_char2-48); //// 0 的Ascll - 48
            
        }else if(hex_char1 >= 'A' && hex_char1 <='F'){
            
            int_ch2 = hex_char2-55; //// A 的Ascll - 65
            
        }else{
            
            int_ch2 = hex_char2-87; //// a 的Ascll - 97
        }
        int_ch = int_ch1+int_ch2;
        
        bytes[j] = int_ch;  ///将转化后的数放入Byte数组里
        
        j++;
    }
    return [[NSData alloc] initWithBytes:bytes length:hexString.length*0.5];
}

@end

@implementation NSString (WZCode)

/**
 *  url编码
 @" !\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~"
 %20%21%22%23%24%25%26%27%28%29%2A%2B%2C%2D%2E%2F%3A%3B%3C%3D%3E%3F%40%5B%5C%5D%5E%5F%60%7B%7C%7D%7E
 */
- (NSString *)wwz_urlEncode{
    
    return [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@" !\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~"].invertedSet];
    //    return [self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}
/**
 *  url解码
 */
- (NSString *)wwz_urlDecode{
    
    return [self stringByRemovingPercentEncoding];
    //    return [self stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

/**
 *  unicode转码成中文
 */
- (NSString *)wwz_utf8StringByReplaceUnicode{
    
    NSMutableString *convertedString = [self mutableCopy];
    [convertedString replaceOccurrencesOfString:@"\\U" withString:@"\\u" options:0 range:NSMakeRange(0, convertedString.length)];
    CFStringRef transform = CFSTR("Any-Hex/Java");
    CFStringTransform((__bridge CFMutableStringRef)convertedString, NULL, transform, YES);
    return convertedString;
}

/**
 *  unicode编码以\u开头
 */
+ (NSString *)replaceUnicode:(NSString *)unicodeStr{
    
    NSString *tempStr1 = [unicodeStr stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 = [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString* returnStr = [NSPropertyListSerialization propertyListFromData:tempData
                                                           mutabilityOption:NSPropertyListImmutable
                                                                     format:NULL
                                                           errorDescription:NULL];
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n"withString:@"\n"];
}

- (NSString *)unicdeDecode{
    if (![self hasPrefix:@"u"]) {
        return self;
    }
    return [NSString replaceUnicode:[[self stringByReplacingOccurrencesOfString:@"null" withString:@""] stringByReplacingOccurrencesOfString:@"u" withString:@"\\u"]];
}

- (NSString *)socketUnicodeDeCode{
    if ([self rangeOfString:@"\\\\u"].length == 0) {
        return self;
    }
    return [NSString replaceUnicode:[self stringByReplacingOccurrencesOfString:@"\\\\u" withString:@"\\u"]];
    
}


/**
 *  URL编码
 */
+ (NSString *)encodeToPercentEscapeString: (NSString *) input{
    CFStringRef output = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)input, NULL, (CFStringRef)@"+!*'()", kCFStringEncodingUTF8);
    NSString *outputStr = [NSString stringWithFormat:@"%@",(__bridge NSString *)(output)];
    CFRelease(output);
    return outputStr;
}

/**
 *  URL解码
 */
+ (NSString *)decodeFromPercentEscapeString: (NSString *) input{
    NSMutableString *outputStr = [NSMutableString stringWithString:input];
    [outputStr replaceOccurrencesOfString:@"+"
                               withString:@" "
                                  options:NSLiteralSearch
                                    range:NSMakeRange(0, [outputStr length])];
    
    return [outputStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}


//1) 将一个字符的Unicode(UCS-2和UCS-4)编码转换成UTF-8编码.

// #c---
/*****************************************************************************
 * 将一个字符的Unicode(UCS-2和UCS-4)编码转换成UTF-8编码.
 *
 * 参数:
 *    unic     字符的Unicode编码值
 *    pOutput  指向输出的用于存储UTF8编码值的缓冲区的指针
 *    outsize  pOutput缓冲的大小
 *
 * 返回值:
 *    返回转换后的字符的UTF8编码所占的字节数, 如果出错则返回 0 .
 *
 * 注意:
 *     1. UTF8没有字节序问题, 但是Unicode有字节序要求;
 *        字节序分为大端(Big Endian)和小端(Little Endian)两种;
 *        在Intel处理器中采用小端法表示, 在此采用小端法表示. (低地址存低位)
 *     2. 请保证 pOutput 缓冲区有最少有 6 字节的空间大小!
 ****************************************************************************/
int enc_unicode_to_utf8_one(unsigned long unic, unsigned char *pOutput,
                            int outSize)
{
    assert(pOutput != NULL);
    assert(outSize >= 6);
    
    if ( unic <= 0x0000007F )
    {
        // * U-00000000 - U-0000007F:  0xxxxxxx
        *pOutput     = (unic & 0x7F);
        return 1;
    }
    else if ( unic >= 0x00000080 && unic <= 0x000007FF )
    {
        // * U-00000080 - U-000007FF:  110xxxxx 10xxxxxx
        *(pOutput+1) = (unic & 0x3F) | 0x80;
        *pOutput     = ((unic >> 6) & 0x1F) | 0xC0;
        return 2;
    }
    else if ( unic >= 0x00000800 && unic <= 0x0000FFFF )
    {
        // * U-00000800 - U-0000FFFF:  1110xxxx 10xxxxxx 10xxxxxx
        *(pOutput+2) = (unic & 0x3F) | 0x80;
        *(pOutput+1) = ((unic >>  6) & 0x3F) | 0x80;
        *pOutput     = ((unic >> 12) & 0x0F) | 0xE0;
        return 3;
    }
    else if ( unic >= 0x00010000 && unic <= 0x001FFFFF )
    {
        // * U-00010000 - U-001FFFFF:  11110xxx 10xxxxxx 10xxxxxx 10xxxxxx
        *(pOutput+3) = (unic & 0x3F) | 0x80;
        *(pOutput+2) = ((unic >>  6) & 0x3F) | 0x80;
        *(pOutput+1) = ((unic >> 12) & 0x3F) | 0x80;
        *pOutput     = ((unic >> 18) & 0x07) | 0xF0;
        return 4;
    }
    else if ( unic >= 0x00200000 && unic <= 0x03FFFFFF )
    {
        // * U-00200000 - U-03FFFFFF:  111110xx 10xxxxxx 10xxxxxx 10xxxxxx 10xxxxxx
        *(pOutput+4) = (unic & 0x3F) | 0x80;
        *(pOutput+3) = ((unic >>  6) & 0x3F) | 0x80;
        *(pOutput+2) = ((unic >> 12) & 0x3F) | 0x80;
        *(pOutput+1) = ((unic >> 18) & 0x3F) | 0x80;
        *pOutput     = ((unic >> 24) & 0x03) | 0xF8;
        return 5;
    }
    else if ( unic >= 0x04000000 && unic <= 0x7FFFFFFF )
    {
        // * U-04000000 - U-7FFFFFFF:  1111110x 10xxxxxx 10xxxxxx 10xxxxxx 10xxxxxx 10xxxxxx
        *(pOutput+5) = (unic & 0x3F) | 0x80;
        *(pOutput+4) = ((unic >>  6) & 0x3F) | 0x80;
        *(pOutput+3) = ((unic >> 12) & 0x3F) | 0x80;
        *(pOutput+2) = ((unic >> 18) & 0x3F) | 0x80;
        *(pOutput+1) = ((unic >> 24) & 0x3F) | 0x80;
        *pOutput     = ((unic >> 30) & 0x01) | 0xFC;
        return 6;
    }
    
    return 0;
}


@end

@implementation NSString (WZSize)

/**
 *  sting width
 *
 *  @param font     font
 *  @param maxHeight maxHeight
 *
 *  @return sting width
 */
- (CGFloat)wwz_stringWidthWithFont:(UIFont*)font maxHeight:(CGFloat)maxHeight{
    
    return [self wwz_stringSizeWithFont:font maxSize:CGSizeMake(CGFLOAT_MAX, maxHeight)].width;
}

/**
 *  sting height
 *
 *  @param font     font
 *  @param maxWidth maxWidth
 *
 *  @return sting height
 */
- (CGFloat)wwz_stringHeightWithFont:(UIFont *)font maxWidth:(CGFloat)maxWidth{
    
    return [self wwz_stringSizeWithFont:font maxSize:CGSizeMake(maxWidth, CGFLOAT_MAX)].height;
}

/**
 *  string size
 *
 *  @param font    font
 *  @param maxSize maxSize
 *
 *  @return fit size
 */
- (CGSize)wwz_stringSizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize{
    
    NSStringDrawingOptions options =  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    CGRect rectToFit = [self boundingRectWithSize:maxSize options:options attributes:@{NSFontAttributeName:font} context:nil];
    
    // 向上取整
    return CGSizeMake(ceilf(rectToFit.size.width), ceilf(rectToFit.size.height));
}

@end

@implementation NSString (Check)

/**
 *  判断字符串中是否含有空格
 */
+ (BOOL)isHaveSpaceInString:(NSString *)string{
    NSRange _range = [string rangeOfString:@" "];
    if (_range.location != NSNotFound) {
        return YES;
    }else {
        return NO;
    }
}

/**
 *  判断字符串中是否含有中文
 */
+ (BOOL)isHaveChineseInString:(NSString *)string
{
    for(NSInteger i = 0; i < [string length]; i++){
        int a = [string characterAtIndex:i];
        if (a > 0x4e00 && a < 0x9fff) {
            return YES;
        }
    }
    return NO;
}

/**
 *  判断字符串是否全部为数字
 */
+ (BOOL)isAllNum:(NSString *)string
{
    unichar c;
    for (int i=0; i<string.length; i++) {
        c=[string characterAtIndex:i];
        if (!isdigit(c)) {
            return NO;
        }
    }
    return YES;
}
/**
 *  判断是否是纯数字
 */
+ (BOOL)isPureInteger:(NSString *)str {
    NSScanner *scanner = [NSScanner scannerWithString:str];
    NSInteger val;
    return [scanner scanInteger:&val] && [scanner isAtEnd];
}

/**
 *  判断手机号码格式是否正确，利用正则表达式验证
 *
 *  @return
 */
+ (BOOL)isMobileNumber:(NSString *)mobileNum
{
    if (mobileNum.length != 11)
    {
        return NO;
    }
    /**
     * 手机号码:
     * 13[0-9], 14[5,7], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 17[6, 7, 8], 18[0-9], 170[0-9]
     * 移动号段: 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
     * 联通号段: 130,131,132,155,156,185,186,145,176,1709
     * 电信号段: 133,153,180,181,189,177,1700
     */
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|70)\\d{8}$";
    /**
     * 中国移动：China Mobile
     * 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
     */
    NSString *CM = @"(^1(3[4-9]|4[7]|5[0-27-9]|7[8]|8[2-478])\\d{8}$)|(^1705\\d{7}$)";
    /**
     * 中国联通：China Unicom
     * 130,131,132,155,156,185,186,145,176,1709
     */
    NSString *CU = @"(^1(3[0-2]|4[5]|5[56]|7[6]|8[56])\\d{8}$)|(^1709\\d{7}$)";
    /**
     * 中国电信：China Telecom
     * 133,153,180,181,189,177,1700
     */
    NSString *CT = @"(^1(33|53|77|8[019])\\d{8}$)|(^1700\\d{7}$)";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}
/**
 *  判断邮箱格式是否正确，利用正则表达式验证
 */
+ (BOOL)isAvailableEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

/**
 *  9. 验证身份证(本人试过,还挺准的)
 */
+ (BOOL)checkIdentityCardNo:(NSString*)value {
    value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSInteger length =0;
    if (!value) {
        return NO;
    }else {
        length = value.length;
        if (length !=15 && length !=18) {
            return NO;
        }
    }
    // 省份代码
    NSArray *areasArray =@[@"11",@"12", @"13",@"14", @"15",@"21", @"22",@"23", @"31",@"32", @"33",@"34", @"35",@"36", @"37",@"41", @"42",@"43", @"44",@"45", @"46",@"50", @"51",@"52", @"53",@"54", @"61",@"62", @"63",@"64", @"65",@"71", @"81",@"82", @"91"];
    NSString *valueStart2 = [value substringToIndex:2];
    BOOL areaFlag =NO;
    for (NSString *areaCode in areasArray) {
        if ([areaCode isEqualToString:valueStart2]) {
            areaFlag =YES;
            break;
        }
    }
    if (!areaFlag) {
        return false;
    }
    NSRegularExpression *regularExpression;
    NSUInteger numberofMatch;
    NSInteger year =0;
    switch (length) {
        case 15:
            year = [[value substringWithRange:NSMakeRange(6,2)] integerValue] +1900;
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];//测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];//测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:value                                                 options:NSMatchingReportProgress
                                                                 range:NSMakeRange(0, value.length)];
            if(numberofMatch >0) {
                return YES;
            }else {
                return NO;
            }
        case 18:
            year = [value substringWithRange:NSMakeRange(6,4)].intValue;
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$"
                                                                        options:NSRegularExpressionCaseInsensitive                                                                     error:nil];//测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$"                                                                      options:NSRegularExpressionCaseInsensitive                                                                     error:nil];//测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:value                                                 options:NSMatchingReportProgress                                                     range:NSMakeRange(0, value.length)];
            if(numberofMatch >0) {
                int S = ([value substringWithRange:NSMakeRange(0,1)].intValue + [value substringWithRange:NSMakeRange(10,1)].intValue) *7 + ([value substringWithRange:NSMakeRange(1,1)].intValue + [value substringWithRange:NSMakeRange(11,1)].intValue) *9 + ([value substringWithRange:NSMakeRange(2,1)].intValue + [value substringWithRange:NSMakeRange(12,1)].intValue) *10 + ([value substringWithRange:NSMakeRange(3,1)].intValue + [value substringWithRange:NSMakeRange(13,1)].intValue) *5 + ([value substringWithRange:NSMakeRange(4,1)].intValue + [value substringWithRange:NSMakeRange(14,1)].intValue) *8 + ([value substringWithRange:NSMakeRange(5,1)].intValue + [value substringWithRange:NSMakeRange(15,1)].intValue) *4 + ([value substringWithRange:NSMakeRange(6,1)].intValue + [value substringWithRange:NSMakeRange(16,1)].intValue) *2 + [value substringWithRange:NSMakeRange(7,1)].intValue *1 + [value substringWithRange:NSMakeRange(8,1)].intValue *6 + [value substringWithRange:NSMakeRange(9,1)].intValue *3;
                int Y = S ;
                NSString *M =@"F";
                NSString *JYM =@"10X98765432";
                M = [JYM substringWithRange:NSMakeRange(Y,1)];// 判断校验位
                if ([M isEqualToString:[value substringWithRange:NSMakeRange(17,1)]]) {
                    return YES;// 检测ID的校验位
                }else {
                    return NO;
                }
            }else {
                return NO;
            }
        default:
            return false;
    }
}
@end
