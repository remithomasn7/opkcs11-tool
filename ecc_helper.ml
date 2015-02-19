
exception UnsupportedNamedCurve

let supported_named_curves = [
   "FRP256v1";
   "c2pnb163v1"; "c2pnb163v2"; "c2pnb163v3"; "c2tnb191v1"; "c2tnb191v2";
   "c2tnb191v3"; "c2pnb208w1"; "c2tnb239v1"; "c2tnb239v2"; "c2tnb239v3";
   "c2pnb272w1"; "c2tnb359v1"; "c2pnb368w1"; "c2tnb431r1";
   "prime192v1"; "prime192v2"; "prime192v3"; "prime239v1"; "prime239v2";
   "prime239v3"; "prime256v1";
   "brainpoolP160r1"; "brainpoolP160t1"; "brainpoolP192r1"; "brainpoolP192t1";
   "brainpoolP224r1"; "brainpoolP224t1"; "brainpoolP256r1"; "brainpoolP256t1";
   "brainpoolP320r1"; "brainpoolP320t1"; "brainpoolP384r1"; "brainpoolP384t1";
   "brainpoolP512r1"; "brainpoolP512t1";
   "sect163k1"; "sect163r1"; "sect239k1"; "sect113r1"; "sect113r2"; "secp112r1";
   "secp112r2"; "secp160r1"; "secp160k1"; "secp256k1"; "sect163r2"; "sect283k1";
   "sect283r1"; "sect131r1"; "sect131r2"; "sect193r1"; "sect193r2"; "sect233k1";
   "sect233r1"; "secp128r1"; "secp128r2"; "secp160r2"; "secp192k1"; "secp224k1";
   "secp224r1"; "secp384r1"; "secp521r1"; "sect409k1"; "sect409r1"; "sect571k1";
   "sect571r1";
   ]

(* Ocaml <4.00.1 does not include List.iteri, use the one in Helpers *)
IFDEF NEED_CUSTOM_LISTITERI THEN
let print_supported_named_curve _ =
    Printf.printf "List of known named curves:";
    Helpers.iteri (fun a b -> if compare (a mod 5) 0 = 0 then
                               Printf.printf "\n";
                            (Printf.printf "%s ")b
               ) supported_named_curves;
    Printf.printf "\n";
    ()
ELSE
(* List.iteri is ugly but useful to "pretty" print the curve list *)
let print_supported_named_curve _ =
    Printf.printf "List of known named curves:";
    List.iteri (fun a b -> if compare (a mod 5) 0 = 0 then
                               Printf.printf "\n";
                            (Printf.printf "%s ")b
               ) supported_named_curves;
    Printf.printf "\n";
    ()
ENDIF

(* generated using:
   openssl ecparam -name ${named_curve} -out ./${named_curve}_short.der -outform DER
*)
let match_named_curve_to_oid named_curve = 
    let ec_oid_params = (match named_curve with
    |"" -> Printf.printf "Defaulting to curve prime256v1\n";
          "06082a8648ce3d030107"
    | "FRP256v1" -> "06092b2403030208010101"
    | "brainpoolP160r1" -> "06092b2403030208010101"
    | "brainpoolP160t1" -> "06092b2403030208010102"
    | "brainpoolP192r1" -> "06092b2403030208010103"
    | "brainpoolP192t1" -> "06092b2403030208010104"
    | "brainpoolP224r1" -> "06092b2403030208010105"
    | "brainpoolP224t1" -> "06092b2403030208010106"
    | "brainpoolP256r1" -> "06092b2403030208010107"
    | "brainpoolP256t1" -> "06092b2403030208010108"
    | "brainpoolP320r1" -> "06092b2403030208010109"
    | "brainpoolP320t1" -> "06092b240303020801010a"
    | "brainpoolP384r1" -> "06092b240303020801010b"
    | "brainpoolP384t1" -> "06092b240303020801010c"
    | "brainpoolP512r1" -> "06092b240303020801010d"
    | "brainpoolP512t1" -> "06092b240303020801010e"
    | "c2pnb163v1" -> "06082a8648ce3d030001"
    | "c2pnb163v2" -> "06082a8648ce3d030002"
    | "c2pnb163v3" -> "06082a8648ce3d030003"
    | "c2pnb208w1" -> "06082a8648ce3d03000a"
    | "c2pnb272w1" -> "06082a8648ce3d030010"
    | "c2pnb368w1" -> "06082a8648ce3d030013"
    | "c2tnb191v1" -> "06082a8648ce3d030005"
    | "c2tnb191v2" -> "06082a8648ce3d030006"
    | "c2tnb191v3" -> "06082a8648ce3d030007"
    | "c2tnb239v1" -> "06082a8648ce3d03000b"
    | "c2tnb239v2" -> "06082a8648ce3d03000c"
    | "c2tnb239v3" -> "06082a8648ce3d03000d"
    | "c2tnb359v1" -> "06082a8648ce3d030012"
    | "c2tnb431r1" -> "06082a8648ce3d030014"
    | "prime192v1" -> "06082a8648ce3d030101"
    | "prime192v2" -> "06082a8648ce3d030102"
    | "prime192v3" -> "06082a8648ce3d030103"
    | "prime239v1" -> "06082a8648ce3d030104"
    | "prime239v2" -> "06082a8648ce3d030105"
    | "prime239v3" -> "06082a8648ce3d030106"
    | "prime256v1" -> "06082a8648ce3d030107"
    | "secp112r1" -> "06052b81040006"
    | "secp112r2" -> "06052b81040007"
    | "secp128r1" -> "06052b8104001c"
    | "secp128r2" -> "06052b8104001d"
    | "secp160k1" -> "06052b81040009"
    | "secp160r1" -> "06052b81040008"
    | "secp160r2" -> "06052b8104001e"
    | "secp192k1" -> "06052b8104001f"
    | "secp224k1" -> "06052b81040020"
    | "secp224r1" -> "06052b81040021"
    | "secp256k1" -> "06052b8104000a"
    | "secp384r1" -> "06052b81040022"
    | "secp521r1" -> "06052b81040023"
    | "sect113r1" -> "06052b81040004"
    | "sect113r2" -> "06052b81040005"
    | "sect131r1" -> "06052b81040016"
    | "sect131r2" -> "06052b81040017"
    | "sect163k1" -> "06052b81040001"
    | "sect163r1" -> "06052b81040002"
    | "sect163r2" -> "06052b8104000f"
    | "sect193r1" -> "06052b81040018"
    | "sect193r2" -> "06052b81040019"
    | "sect233k1" -> "06052b8104001a"
    | "sect233r1" -> "06052b8104001b"
    | "sect239k1" -> "06052b81040003"
    | "sect283k1" -> "06052b81040010"
    | "sect283r1" -> "06052b81040011"
    | "sect409k1" -> "06052b81040024"
    | "sect409r1" -> "06052b81040025"
    | "sect571k1" -> "06052b81040026"
    | "sect571r1" -> "06052b81040027"
    | _ -> print_supported_named_curve () ; raise UnsupportedNamedCurve ) in
    (ec_oid_params)

(* generated using:
   openssl ecparam -name ${named_curve} -out ./${named_curve}_long.der -outform DER -param_enc explicit -no_seed
*)
let match_named_curve_to_explicit_params named_curve = 
    let ec_explicit_params = (match named_curve with
    |"" -> Printf.printf "Defaulting to curve prime256v1\n";
           "3081e0020101302c06072a8648ce3d0101022100ffffffff00000001000000000000000000000000ffffffffffffffffffffffff30440420ffffffff00000001000000000000000000000000fffffffffffffffffffffffc04205ac635d8aa3a93e7b3ebbd55769886bc651d06b0cc53b0f63bce3c3e27d2604b0441046b17d1f2e12c4247f8bce6e563a440f277037d812deb33a0f4a13945d898c2964fe342e2fe1a7f9b8ee7eb4a7c0f9e162bce33576b315ececbb6406837bf51f5022100ffffffff00000000ffffffffffffffffbce6faada7179e84f3b9cac2fc632551020101"
    | "FRP256v1" -> "3081e0020101302c06072a8648ce3d0101022100f1fd178c0b3ad58f10126de8ce42435b3961adbcabc8ca6de8fcf353d86e9c0330440420f1fd178c0b3ad58f10126de8ce42435b3961adbcabc8ca6de8fcf353d86e9c000420ee353fca5428a9300d4aba754a44c00fdfec0c9ae4b1a1803075ed967b7bb73f044104b6b3d4c356c139eb31183d4749d423958c27d2dcaf98b70164c97a2dd98f5cff6142e0f7c8b204911f9271f0f3ecef8c2701c307e8e4c9e183115a1554062cfb022100f1fd178c0b3ad58f10126de8ce42435b53dc67e140d2bf941ffdd459c6d655e1020101"
    | "brainpoolP160r1" -> "308198020101302006072a8648ce3d0101021500e95e4a5f737059dc60dfc7ad95b3d8139515620f302c0414340e7be2a280eb74e2be61bada745d97e8f7c30004141e589a8595423412134faa2dbdec95c8d8675e58042904bed5af16ea3f6a4f62938c4631eb5af7bdbcdbc31667cb477a1a8ec338f94741669c976316da6321021500e95e4a5f737059dc60df5991d45029409e60fc09020101"
    | "brainpoolP160t1" -> "308198020101302006072a8648ce3d0101021500e95e4a5f737059dc60dfc7ad95b3d8139515620f302c0414e95e4a5f737059dc60dfc7ad95b3d8139515620c04147a556b6dae535b7b51ed2c4d7daa7a0b5c55f380042904b199b13b9b34efc1397e64baeb05acc265ff2378add6718b7c7c1961f0991b842443772152c9e0ad021500e95e4a5f737059dc60df5991d45029409e60fc09020101"
    | "brainpoolP192r1" -> "3081b0020101302406072a8648ce3d0101021900c302f41d932a36cda7a3463093d18db78fce476de1a86297303404186a91174076b1e0e19c39c031fe8685c1cae040e5c69a28ef0418469a28ef7c28cca3dc721d044f4496bcca7ef4146fbf25c9043104c0a0647eaab6a48753b033c56cb0f0900a2f5c4853375fd614b690866abd5bb88b5f4828c1490002e6773fa2fa299b8f021900c302f41d932a36cda7a3462f9e9e916b5be8f1029ac4acc1020101"
    | "brainpoolP192t1" -> "3081b0020101302406072a8648ce3d0101021900c302f41d932a36cda7a3463093d18db78fce476de1a8629730340418c302f41d932a36cda7a3463093d18db78fce476de1a86294041813d56ffaec78681e68f9deb43b35bec2fb68542e27897b790431043ae9e58c82f63c30282e1fe7bbf43fa72c446af6f4618129097e2c5667c2223a902ab5ca449d0084b7e5b3de7ccc01c9021900c302f41d932a36cda7a3462f9e9e916b5be8f1029ac4acc1020101"
    | "brainpoolP224r1" -> "3081c8020101302806072a8648ce3d0101021d00d7c134aa264366862a18302575d1d787b09f075797da89f57ec8c0ff303c041c68a5e62ca9ce6c1c299803a6c1530b514e182ad8b0042a59cad29f43041c2580f63ccfe44138870713b1a92369e33e2135d266dbb372386c400b0439040d9029ad2c7e5cf4340823b2a87dc68c9e4ce3174c1e6efdee12c07d58aa56f772c0726f24c6b89e4ecdac24354b9e99caa3f6d3761402cd021d00d7c134aa264366862a18302575d0fb98d116bc4b6ddebca3a5a7939f020101"
    | "brainpoolP224t1" -> "3081c8020101302806072a8648ce3d0101021d00d7c134aa264366862a18302575d1d787b09f075797da89f57ec8c0ff303c041cd7c134aa264366862a18302575d1d787b09f075797da89f57ec8c0fc041c4b337d934104cd7bef271bf60ced1ed20da14c08b3bb64f18a60888d0439046ab1e344ce25ff3896424e7ffe14762ecb49f8928ac0c76029b4d5800374e9f5143e568cd23f3f4d7c0d4b1e41c8cc0d1c6abd5f1a46db4c021d00d7c134aa264366862a18302575d0fb98d116bc4b6ddebca3a5a7939f020101"
    | "brainpoolP256r1" -> "3081e0020101302c06072a8648ce3d0101022100a9fb57dba1eea9bc3e660a909d838d726e3bf623d52620282013481d1f6e5377304404207d5a0975fc2c3057eef67530417affe7fb8055c126dc5c6ce94a4b44f330b5d9042026dc5c6ce94a4b44f330b5d9bbd77cbf958416295cf7e1ce6bccdc18ff8c07b60441048bd2aeb9cb7e57cb2c4b482ffc81b7afb9de27e1e3bd23c23a4453bd9ace3262547ef835c3dac4fd97f8461a14611dc9c27745132ded8e545c1d54c72f046997022100a9fb57dba1eea9bc3e660a909d838d718c397aa3b561a6f7901e0e82974856a7020101"
    | "brainpoolP256t1" -> "3081e0020101302c06072a8648ce3d0101022100a9fb57dba1eea9bc3e660a909d838d726e3bf623d52620282013481d1f6e537730440420a9fb57dba1eea9bc3e660a909d838d726e3bf623d52620282013481d1f6e53740420662c61c430d84ea4fe66a7733d0b76b7bf93ebc4af2f49256ae58101fee92b04044104a3e8eb3cc1cfe7b7732213b23a656149afa142c47aafbc2b79a191562e1305f42d996c823439c56d7f7b22e14644417e69bcb6de39d027001dabe8f35b25c9be022100a9fb57dba1eea9bc3e660a909d838d718c397aa3b561a6f7901e0e82974856a7020101"
    | "brainpoolP320r1" -> "30820110020101303406072a8648ce3d0101022900d35e472036bc4fb7e13c785ed201e065f98fcfa6f6f40def4f92b9ec7893ec28fcd412b1f1b32e27305404283ee30b568fbab0f883ccebd46d3f3bb8a2a73513f5eb79da66190eb085ffa9f492f375a97d860eb40428520883949dfdbc42d3ad198640688a6fe13f41349554b49acc31dccd884539816f5eb4ac8fb1f1a604510443bd7e9afb53d8b85289bcc48ee5bfe6f20137d10a087eb6e7871e2a10a599c710af8d0d39e2061114fdd05545ec1cc8ab4093247f77275e0743ffed117182eaa9c77877aaac6ac7d35245d1692e8ee1022900d35e472036bc4fb7e13c785ed201e065f98fcfa5b68f12a32d482ec7ee8658e98691555b44c59311020101"
    | "brainpoolP320t1" -> "30820110020101303406072a8648ce3d0101022900d35e472036bc4fb7e13c785ed201e065f98fcfa6f6f40def4f92b9ec7893ec28fcd412b1f1b32e2730540428d35e472036bc4fb7e13c785ed201e065f98fcfa6f6f40def4f92b9ec7893ec28fcd412b1f1b32e240428a7f561e038eb1ed560b3d147db782013064c19f27ed27c6780aaf77fb8a547ceb5b4fef422340353045104925be9fb01afc6fb4d3e7d4990010f813408ab106c4f09cb7ee07868cc136fff3357f624a21bed5263ba3a7a27483ebf6671dbef7abb30ebee084e58a0b077ad42a5a0989d1ee71b1b9bc0455fb0d2c3022900d35e472036bc4fb7e13c785ed201e065f98fcfa5b68f12a32d482ec7ee8658e98691555b44c59311020101"
    | "brainpoolP384r1" -> "30820140020101303c06072a8648ce3d01010231008cb91e82a3386d280f5d6f7e50e641df152f7109ed5456b412b1da197fb71123acd3a729901d1a71874700133107ec53306404307bc382c63d8c150c3c72080ace05afa0c2bea28e4fb22787139165efba91f90f8aa5814a503ad4eb04a8c7dd22ce2826043004a8c7dd22ce28268b39b55416f0447c2fb77de107dcd2a62e880ea53eeb62d57cb4390295dbc9943ab78696fa504c110461041d1c64f068cf45ffa2a63a81b7c13f6b8847a3e77ef14fe3db7fcafe0cbd10e8e826e03436d646aaef87b2e247d4af1e8abe1d7520f9c2a45cb1eb8e95cfd55262b70b29feec5864e19c054ff99129280e4646217791811142820341263c53150231008cb91e82a3386d280f5d6f7e50e641df152f7109ed5456b31f166e6cac0425a7cf3ab6af6b7fc3103b883202e9046565020101"
    | "brainpoolP384t1" -> "30820140020101303c06072a8648ce3d01010231008cb91e82a3386d280f5d6f7e50e641df152f7109ed5456b412b1da197fb71123acd3a729901d1a71874700133107ec53306404308cb91e82a3386d280f5d6f7e50e641df152f7109ed5456b412b1da197fb71123acd3a729901d1a71874700133107ec5004307f519eada7bda81bd826dba647910f8c4b9346ed8ccdc64e4b1abd11756dce1d2074aa263b88805ced70355a33b471ee04610418de98b02db9a306f2afcd7235f72a819b80ab12ebd653172476fecd462aabffc4ff191b946a5f54d8d0aa2f418808cc25ab056962d30651a114afd2755ad336747f93475b7a1fca3b88f2b6a208ccfe469408584dc2b2912675bf5b9e5829280231008cb91e82a3386d280f5d6f7e50e641df152f7109ed5456b31f166e6cac0425a7cf3ab6af6b7fc3103b883202e9046565020101"
    | "brainpoolP512r1" -> "308201a2020101304c06072a8648ce3d0101024100aadd9db8dbe9c48b3fd4e6ae33c9fc07cb308db3b3c9d20ed6639cca703308717d4d9b009bc66842aecda12ae6a380e62881ff2f2d82c68528aa6056583a48f330818404407830a3318b603b89e2327145ac234cc594cbdd8d3df91610a83441caea9863bc2ded5d5aa8253aa10a2ef1c98b9ac8b57f1117a72bf2c7b9e7c1ac4d77fc94ca04403df91610a83441caea9863bc2ded5d5aa8253aa10a2ef1c98b9ac8b57f1117a72bf2c7b9e7c1ac4d77fc94cadc083e67984050b75ebae5dd2809bd638016f7230481810481aee4bdd82ed9645a21322e9c4c6a9385ed9f70b5d916c1b43b62eef4d0098eff3b1f78e2d0d48d50d1687b93b97d5f7c6d5047406a5e688b352209bcb9f8227dde385d566332ecc0eabfa9cf7822fdf209f70024a57b1aa000c55b881f8111b2dcde494a5f485e5bca4bd88a2763aed1ca2b2fa8f0540678cd1e0f3ad80892024100aadd9db8dbe9c48b3fd4e6ae33c9fc07cb308db3b3c9d20ed6639cca70330870553e5c414ca92619418661197fac10471db1d381085ddaddb58796829ca90069020101"
    | "brainpoolP512t1" -> "308201a2020101304c06072a8648ce3d0101024100aadd9db8dbe9c48b3fd4e6ae33c9fc07cb308db3b3c9d20ed6639cca703308717d4d9b009bc66842aecda12ae6a380e62881ff2f2d82c68528aa6056583a48f33081840440aadd9db8dbe9c48b3fd4e6ae33c9fc07cb308db3b3c9d20ed6639cca703308717d4d9b009bc66842aecda12ae6a380e62881ff2f2d82c68528aa6056583a48f004407cbbbcf9441cfab76e1890e46884eae321f70c0bcb4981527897504bec3e36a62bcdfa2304976540f6450085f2dae145c22553b465763689180ea2571867423e04818104640ece5c12788717b9c1ba06cbc2a6feba85842458c56dde9db1758d39c0313d82ba51735cdb3ea499aa77a7d6943a64f7a3f25fe26f06b51baa2696fa9035da5b534bd595f5af0fa2c892376c84ace1bb4e3019b71634c01131159cae03cee9d9932184beef216bd71df2dadf86a627306ecff96dbb8bace198b61e00f8b332024100aadd9db8dbe9c48b3fd4e6ae33c9fc07cb308db3b3c9d20ed6639cca70330870553e5c414ca92619418661197fac10471db1d381085ddaddb58796829ca90069020101"
    | "c2pnb163v1" -> "3081a0020101302506072a8648ce3d0102301a020200a306092a8648ce3d010203033009020101020102020108302d0415072546b5435234a422e0789675f432c89435de52420414c9517d06d5240d3cff38c74b20b6cd4d6f9dd4d9042b0407af69989546103d79329fcc3d74880f33bbe803cb01ec23211b5966adea1d3f87f7ea5848aef0b7ca9f02150400000000000000000001e60fc8821cc74daeafc1020102"
    | "c2pnb163v2" -> "3081a1020101302506072a8648ce3d0102301a020200a306092a8648ce3d010203033009020101020102020108302e04150108b39e77c4b108bed981ed0e890e117c511cf07204150667aceb38af4e488c407433ffae4f1c811638df20042b040024266e4eb5106d0a964d92c4860e2671db9b6cc5079f684ddf6684c5cd258b3890021b2386dfd19fc5021503fffffffffffffffffffdf64de1151adbb78f10a7020102"
    | "c2pnb163v3" -> "3081a1020101302506072a8648ce3d0102301a020200a306092a8648ce3d010203033009020101020102020108302e041507a526c63d3e25a256a007699f5447e32ae456b50e041503f7061798eb99e238fd6f1bf95b48feeb4854252b042b0402f9f87b7c574d0bdecf8a22e6524775f98cdebdcb05b935590c155e17ea48eb3ff3718b893df59a05d0021503fffffffffffffffffffe1aee140f110aff961309020102"
    | "c2pnb208w1" -> "3081a2020101302506072a8648ce3d0102301a020200d006092a8648ce3d010203033009020101020102020153301f040100041ac8619ed45a62e6212e1160349e2bfa844439fafc2a3fd1638f9e04350489fdfbe4abe193df9559ecf07ac0ce78554e2784eb8c1ed1a57a0f55b51a06e78e9ac38a035ff520d8b01781beb1a6bb08617de302190101baf95c9723c57b6c21da2eff2d5ed588bdd5717e212f9d020300fe48"
    | "c2pnb272w1" -> "3081e3020101302506072a8648ce3d0102301a0202011006092a8648ce3d0102030330090201010201030201383048042291a091f03b5fba4ab2ccf49c4edd220fb028712d42be752b2c40094dbacdb586fb2004227167efc92bb2e3ce7c8aaaff34e12a9c557003d7c73a6faf003f99f6cc8482e540f70445046108babb2ceebcf787058a056cbe0cfe622d7723a289e08a07ae13ef0d10d171dd8d10c7695716851eef6ba7f6872e6142fbd241b830ff5efcaceccab05e02005dde9d2302210100faf51354e0e39e4892df6e319c72c8161603fa45aa7b998a167b8f1e629521020300ff06"
    | "c2pnb368w1" -> "3082011f020101302506072a8648ce3d0102301a0202017006092a8648ce3d0102030330090201010201020201553060042ee0d2ee25095206f5e2a4f9ed229f1f256e79a0e2b455970d8d0d865bd94778c576d62f0ab7519ccd2a1a906ae30d042efc1217d4320a90452c760a58edcd30c8dd069b3c34453837a34ed50cb54917e1c2112d84d164f444f8f74786046a045d041085e2755381dccce3c1557afa10c2f0c0c2825646c5b34a394cbcfa8bc16b22e7e789e927be216f02e1fb136a5f7b3eb1bddcba62d5d8b2059b525797fc73822c59059c623a45ff3843cee8f87cd1855adaa81e2a0750b80fda2310022d010090512da9af72b08349d98a5dd4c7b0532eca51ce03e2d10f3b7ac579bd87e909ae40a6f131e9cfce5bd967020300ff70"
    | "c2tnb191v1" -> "3081a8020101301d06072a8648ce3d01023012020200bf06092a8648ce3d01020302020109303404182866537b676752636a68f56554e12640276b649ef752626704182e45ef571f00786f67b0081b9495a3d95462f5de0aa185ec04310436b3daf8a23206f9c4f299d7b21a9c369137f2c84ae1aa0d765be73433b3f95e332932e70ea245ca2418ea0ef98018fb021840000000000000000000000004a20e90c39067c893bbb9a5020102"
    | "c2tnb191v2" -> "3081a8020101301d06072a8648ce3d01023012020200bf06092a8648ce3d0102030202010930340418401028774d7777c7b7666d1366ea432071274f89ff01e71804180620048d28bcbd03b6249c99182b7c8cd19700c362c46a010431043809b2b7cc1b28cc5a87926aad83fd28789e81e2c9e3bf1017434386626d14f3dbf01760d9213a3e1cf37aec437d668a021820000000000000000000000050508cb89f652824e06b8173020104"
    | "c2tnb191v3" -> "3081a8020101301d06072a8648ce3d01023012020200bf06092a8648ce3d01020302020109303404186c01074756099122221056911c77d77e77a777e7e7e77fcb041871fe1af926cf847989efef8db459f66394d90f32ad3f15e8043104375d4ce24fde434489de8746e71786015009e66e38a926dd545a39176196575d985999366e6ad34ce0a77cd7127b06be0218155555555555555555555555610c0b196812bfb6288a3ea3020106"
    | "c2tnb239v1" -> "3081c6020101301d06072a8648ce3d01023012020200ef06092a8648ce3d010203020201243040041e32010857077c5431123a46b808906756f543423e8d27877578125778ac76041e790408f2eedaf392b012edefb3392f30f4327c0ca3f31fc383c422aa8c16043d0457927098fa932e7c0a96d3fd5b706ef7e5f5c156e16b7e7c86038552e91d61d8ee5077c33fecf6f1a16b268de469c3c7744ea9a971649fc7a9616305021e2000000000000000000000000000000f4d42ffe1492a4993f1cad666e447020104"
    | "c2tnb239v2" -> "3081c6020101301d06072a8648ce3d01023012020200ef06092a8648ce3d010203020201243040041e4230017757a767fae42398569b746325d45313af0766266479b75654e65f041e5037ea654196cff0cd82b2c14a2fcf2e3ff8775285b545722f03eacdb74b043d0428f9d04e900069c8dc47a08534fe76d2b900b7d7ef31f5709f200c4ca2055667334c45aff3b5a03bad9dd75e2c71a99362567d5453f7fa6e227ec833021e1555555555555555555555555555553c6f2885259c31e3fcdf154624522d020106"
    | "c2tnb239v3" -> "3081c6020101301d06072a8648ce3d01023012020200ef06092a8648ce3d010203020201243040041e01238774666a67766d6676f778e676b66999176666e687666d8766c66a9f041e6a941977ba9f6a435199acfc51067ed587f519c5ecb541b8e44111de1d40043d0470f6e9d04d289c4e89913ce3530bfde903977d42b146d539bf1bde4e9c922e5a0eaf6e5e1305b9004dce5c0ed7fe59a35608f33837c816d80b79f461021e0cccccccccccccccccccccccccccccac4912d2d9df903ef9888b8a0e4cff02010a"
    | "c2tnb359v1" -> "30820111020101301d06072a8648ce3d010230120202016706092a8648ce3d01020302020144305e042d5667676a654b20754f356ea92017d946567c46675556f19556a04616b567d223a5e05656fb549016a96656a557042d2472e2d0197c49363f1fe7f5b6db075d52b6947d135d8ca445805d39bc345626089687742b6329e70680231988045b043c258ef3047767e7ede0f1fdaa79daee3841366a132e163aced4ed2401df9c6bdcde98e8e707c07a2239b1b09753d7e08529547048121e9c95f3791dd804963948f34fae7bf44ea82365dc7868fe57e4ae2de211305a407104bd022d01af286bca1af286bca1af286bca1af286bca1af286bc9fb8f6b85c556892c20a7eb964fe7719e74f490758d3b02014c"
    | "c2tnb431r1" -> "3082013e020101301d06072a8648ce3d01023012020201af06092a8648ce3d01020302020178307004361a827ef00dd6fc0e234caf046c6a5d8a85395b236cc4ad2cf32a0cadbdc9ddf620b0eb9906d0957f6c6feacd615468df104de296cd8f043610d9b4a3d9047d8b154359abfb1b7f5485b04ceb868237ddc9deda982a679a5a919b626d4e50a8dd731b107a9962381fb5d807bf2618046d04120fc05d3c67a99de161d2f4092622feca701be4f50f4758714e8a87bbf2a658ef8c21e7c5efe965361f6c2999c0c247b0dbd70ce6b720d0af8903a96f8d5fa2c255745d3c451b302c9346d9b7e485e7bce41f6b591f3e8f6addcbb0bc4c2f947a7de1a89b625d6a598b376002350340340340340340340340340340340340340340340340340340340323c313fab50589703b5ec68d3587fec60d161cc149c1ad4a9102022760"
    | "prime192v1" -> "3081b0020101302406072a8648ce3d0101021900fffffffffffffffffffffffffffffffeffffffffffffffff30340418fffffffffffffffffffffffffffffffefffffffffffffffc041864210519e59c80e70fa7e9ab72243049feb8deecc146b9b1043104188da80eb03090f67cbf20eb43a18800f4ff0afd82ff101207192b95ffc8da78631011ed6b24cdd573f977a11e794811021900ffffffffffffffffffffffff99def836146bc9b1b4d22831020101"
    | "prime192v2" -> "3081b0020101302406072a8648ce3d0101021900fffffffffffffffffffffffffffffffeffffffffffffffff30340418fffffffffffffffffffffffffffffffefffffffffffffffc0418cc22d6dfb95c6b25e49c0d6364a4e5980c393aa21668d953043104eea2bae7e1497842f2de7769cfe9c989c072ad696f48034a6574d11d69b6ec7a672bb82a083df2f2b0847de970b2de15021900fffffffffffffffffffffffe5fb1a724dc80418648d8dd31020101"
    | "prime192v3" -> "3081b0020101302406072a8648ce3d0101021900fffffffffffffffffffffffffffffffeffffffffffffffff30340418fffffffffffffffffffffffffffffffefffffffffffffffc041822123dc2395a05caa7423daeccc94760a7d462256bd569160431047d29778100c65a1da1783716588dce2b8b4aee8e228f189638a90f22637337334b49dcb66a6dc8f9978aca7648a943b0021900ffffffffffffffffffffffff7a62d031c83f4294f640ec13020101"
    | "prime239v1" -> "3081d2020101302906072a8648ce3d0101021e7fffffffffffffffffffffff7fffffffffff8000000000007fffffffffff3040041e7fffffffffffffffffffffff7fffffffffff8000000000007ffffffffffc041e6b016c3bdcf18941d0d654921475ca71a9db2fb27d1d37796185c2942c0a043d040ffa963cdca8816ccc33b8642bedf905c3d358573d3f27fbbd3b3cb9aaaf7debe8e4e90a5dae6e4054ca530ba04654b36818ce226b39fccb7b02f1ae021e7fffffffffffffffffffffff7fffff9e5e9a9f5d9071fbd1522688909d0b020101"
    | "prime239v2" -> "3081d2020101302906072a8648ce3d0101021e7fffffffffffffffffffffff7fffffffffff8000000000007fffffffffff3040041e7fffffffffffffffffffffff7fffffffffff8000000000007ffffffffffc041e617fab6832576cbbfed50d99f0249c3fee58b94ba0038c7ae84c8c832f2c043d0438af09d98727705120c921bb5e9e26296a3cdcf2f35757a0eafd87b830e75b0125e4dbea0ec7206da0fc01d9b081329fb555de6ef460237dff8be4ba021e7fffffffffffffffffffffff800000cfa7e8594377d414c03821bc582063020101"
    | "prime239v3" -> "3081d2020101302906072a8648ce3d0101021e7fffffffffffffffffffffff7fffffffffff8000000000007fffffffffff3040041e7fffffffffffffffffffffff7fffffffffff8000000000007ffffffffffc041e255705fa2a306654b1f4cb03d6a750a30c250102d4988717d9ba15ab6d3e043d046768ae8e18bb92cfcf005c949aa2c6d94853d0e660bbf854b1c9505fe95a1607e6898f390c06bc1d552bad226f3b6fcfe48b6e818499af18e3ed6cf3021e7fffffffffffffffffffffff7fffff975deb41b3a6057c3c432146526551020101"
    | "prime256v1" -> "3081e0020101302c06072a8648ce3d0101022100ffffffff00000001000000000000000000000000ffffffffffffffffffffffff30440420ffffffff00000001000000000000000000000000fffffffffffffffffffffffc04205ac635d8aa3a93e7b3ebbd55769886bc651d06b0cc53b0f63bce3c3e27d2604b0441046b17d1f2e12c4247f8bce6e563a440f277037d812deb33a0f4a13945d898c2964fe342e2fe1a7f9b8ee7eb4a7c0f9e162bce33576b315ececbb6406837bf51f5022100ffffffff00000000ffffffffffffffffbce6faada7179e84f3b9cac2fc632551020101"
    | "secp112r1" -> "3074020101301a06072a8648ce3d0101020f00db7c2abf62e35e668076bead208b3020040edb7c2abf62e35e668076bead2088040e659ef8ba043916eede8911702b22041d0409487239995a5ee76b55f9c2f098a89ce5af8724c0a23e0e0ff77500020f00db7c2abf62e35e7628dfac6561c5020101"
    | "secp112r2" -> "3073020101301a06072a8648ce3d0101020f00db7c2abf62e35e668076bead208b3020040e6127c24c05f38a0aaaf65c0ef02c040e51def1815db5ed74fcc34c85d709041d044ba30ab5e892b4e1649dd0928643adcd46f5882e3747def36e956e97020e36df0aafd8b8d7597ca10520d04b020104"
    | "secp128r1" -> "308180020101301c06072a8648ce3d0101021100fffffffdffffffffffffffffffffffff30240410fffffffdfffffffffffffffffffffffc0410e87579c11079f43dd824993c2cee5ed3042104161ff7528b899b2d0c28607ca52c5b86cf5ac8395bafeb13c02da292dded7a83021100fffffffe0000000075a30d1b9038a115020101"
    | "secp128r2" -> "307f020101301c06072a8648ce3d0101021100fffffffdffffffffffffffffffffffff30240410d6031998d1b3bbfebf59cc9bbff9aee104105eeefca380d02919dc2c6558bb6d8a5d0421047b6aa5d85e572983e6fb32a7cdebc14027b6916a894d3aee7106fe805fc34b4402103fffffff7fffffffbe0024720613b5a3020104"
    | "secp160k1" -> "3072020101302006072a8648ce3d0101021500fffffffffffffffffffffffffffffffeffffac7330060401000401070429043b4c382ce37aa192a4019e763036f4f5dd4d7ebb938cf935318fdced6bc28286531733c3f03c4fee02150100000000000000000001b8fa16dfab9aca16b6b3020101"
    | "secp160r1" -> "308198020101302006072a8648ce3d0101021500ffffffffffffffffffffffffffffffff7fffffff302c0414ffffffffffffffffffffffffffffffff7ffffffc04141c97befc54bd7a8b65acf89f81d4d4adc565fa450429044a96b5688ef573284664698968c38bb913cbfc8223a628553168947d59dcc912042351377ac5fb3202150100000000000000000001f4c8f927aed3ca752257020101"
    | "secp160r2" -> "308198020101302006072a8648ce3d0101021500fffffffffffffffffffffffffffffffeffffac73302c0414fffffffffffffffffffffffffffffffeffffac700414b4e134d3fb59eb8bab57274904664d5af50388ba04290452dcb034293a117e1f4ff11b30f7199d3144ce6dfeaffef2e331f296e071fa0df9982cfea7d43f2e02150100000000000000000000351ee786a818f3a1a16b020101"
    | "secp192k1" -> "308182020101302406072a8648ce3d0101021900fffffffffffffffffffffffffffffffffffffffeffffee373006040100040103043104db4ff10ec057e9ae26b07d0280b7f4341da5d1b1eae06c7d9b2f2f6d9c5628a7844163d015be86344082aa88d95e2f9d021900fffffffffffffffffffffffe26f2fc170f69466a74defd8d020101"
    | "secp224k1" -> "308192020101302806072a8648ce3d0101021d00fffffffffffffffffffffffffffffffffffffffffffffffeffffe56d3006040100040105043904a1455b334df099df30fc28a169a467e9e47075a90f7e650eb6b7a45c7e089fed7fba344282cafbd6f7e319f7c0b0bd59e2ca4bdb556d61a5021d010000000000000000000000000001dce8d2ec6184caf0a971769fb1f7020101"
    | "secp224r1" -> "3081c8020101302806072a8648ce3d0101021d00ffffffffffffffffffffffffffffffff000000000000000000000001303c041cfffffffffffffffffffffffffffffffefffffffffffffffffffffffe041cb4050a850c04b3abf54132565044b0b7d7bfd8ba270b39432355ffb4043904b70e0cbd6bb4bf7f321390b94a03c1d356c21122343280d6115c1d21bd376388b5f723fb4c22dfe6cd4375a05a07476444d5819985007e34021d00ffffffffffffffffffffffffffff16a2e0b8f03e13dd29455c5c2a3d020101"
    | "secp256k1" -> "3081a2020101302c06072a8648ce3d0101022100fffffffffffffffffffffffffffffffffffffffffffffffffffffffefffffc2f300604010004010704410479be667ef9dcbbac55a06295ce870b07029bfcdb2dce28d959f2815b16f81798483ada7726a3c4655da4fbfc0e1108a8fd17b448a68554199c47d08ffb10d4b8022100fffffffffffffffffffffffffffffffebaaedce6af48a03bbfd25e8cd0364141020101"
    | "secp384r1" -> "30820140020101303c06072a8648ce3d0101023100fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffeffffffff0000000000000000ffffffff30640430fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffeffffffff0000000000000000fffffffc0430b3312fa7e23ee7e4988e056be3f82d19181d9c6efe8141120314088f5013875ac656398d8a2ed19d2a85c8edd3ec2aef046104aa87ca22be8b05378eb1c71ef320ad746e1d3b628ba79b9859f741e082542a385502f25dbf55296c3a545e3872760ab73617de4a96262c6f5d9e98bf9292dc29f8f41dbd289a147ce9da3113b5f0b8c00a60b1ce1d7e819d7a431d7c90ea0e5f023100ffffffffffffffffffffffffffffffffffffffffffffffffc7634d81f4372ddf581a0db248b0a77aecec196accc52973020101"
    | "secp521r1" -> "308201ab020101304d06072a8648ce3d0101024201ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff308187044201fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffc044151953eb9618e1c9a1f929a21a0b68540eea2da725b99b315f3b8b489918ef109e156193951ec7e937b1652c0bd3bb1bf073573df883d2c34f1ef451fd46b503f000481850400c6858e06b70404e9cd9e3ecb662395b4429c648139053fb521f828af606b4d3dbaa14b5e77efe75928fe1dc127a2ffa8de3348b3c1856a429bf97e7e31c2e5bd66011839296a789a3bc0045c8a5fb42c7d1bd998f54449579b446817afbd17273e662c97ee72995ef42640c550b9013fad0761353c7086a272c24088be94769fd16650024201fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffa51868783bf2f966b7fcc0148f709a5d03bb5c9b8899c47aebb6fb71e91386409020101"
    | "sect113r1" -> "3078020101301c06072a8648ce3d0102301102017106092a8648ce3d010203020201093020040e3088250ca6e7c7fe649ce85820f7040ee8bee4d3e2260744188be0e9c723041f04009d73616f35f4ab1407d73562c10f00a52830277958ee84d1315ed31886020f0100000000000000d9ccec8a39e56f020102"
    | "sect113r2" -> "3078020101301c06072a8648ce3d0102301102017106092a8648ce3d010203020201093020040e689918dbec7e5a0dd6dfc0aa55c7040e95e9a9ec9b297bd4bf36e059184f041f0401a57a6a7b26ca5ef52fcdb816479700b3adc94ed1fe674c06e695baba1d020f010000000000000108789b2496af93020102"
    | "sect131r1" -> "30818d020101302506072a8648ce3d0102301a0202008306092a8648ce3d0102030330090201020201030201083026041107a11b09a76b562144418ff3ff8c2570b804110217c05610884b63b9c6c7291678f9d3410423040081baf91fdf9833c40f9c181343638399078c6e7ea38c001f73c8134b1b4ef9e15002110400000000000000023123953a9464b54d020102"
    | "sect131r2" -> "30818d020101302506072a8648ce3d0102301a0202008306092a8648ce3d0102030330090201020201030201083026041103e5a88919d7cafcbf415f07c2176573b2041104b8266a46c55657ac734ce38f018f21920423040356dcd8f2f95031ad652d23951bb366a80648f06d867940a5366d9e265de9eb240f02110400000000000000016954a233049ba98f020102"
    | "sect163k1" -> "3079020101302506072a8648ce3d0102301a020200a306092a8648ce3d0102030330090201030201060201073006040101040101042b0402fe13c0537bbc11acaa07d793de4e6d5e5c94eee80289070fb05d38ff58321f2e800536d538ccdaa3d9021504000000000000000000020108a2e0cc0d99f8a5ef020102"
    | "sect163r1" -> "3081a1020101302506072a8648ce3d0102301a020200a306092a8648ce3d010203033009020103020106020107302e041507b6882caaefa84f9554ff8428bd88e246d2782ae204150713612dcddcb40aab946bda29ca91f73af958afd9042b040369979697ab43897789566789567f787a7876a65400435edb42efafb2989d51fefce3c80988f41ff883021503ffffffffffffffffffff48aab689c29ca710279b020102"
    | "sect163r2" -> "30818d020101302506072a8648ce3d0102301a020200a306092a8648ce3d010203033009020103020106020107301a0401010415020a601907b8c953ca1481eb10512f78744a3205fd042b0403f0eba16286a2d57ea0991168d4994637e8343e3600d51fbc6c71a0094fa2cdd545b11c5c0c797324f10215040000000000000000000292fe77e70c12a4234c33020102"
    | "sect193r1" -> "3081ab020101301d06072a8648ce3d01023012020200c106092a8648ce3d0102030202010f3034041817858feb7a98975169e171f77b4087de098ac8a911df7b010418fdfb49bfe6c3a89facadaa7a1e5bbc7cc1c2e5d83147881404330401f481bc5f0ff84a74ad6cdf6fdef4bf6179625372d8c0c5e10025e399f2903712ccf3ea9e3a1ad17fb0b3201b6af7ce1b05021901000000000000000000000000c7f34a778f443acc920eba49020102"
    | "sect193r2" -> "3081ac020101301d06072a8648ce3d01023012020200c106092a8648ce3d0102030202010f303504190163f35a5137c2ce3ea6ed8667190b0bc43ecd69977702709b0418c9bb9e8927d4d64c377e2ab2856a5b16e3efb7f61d4316ae04330400d9b67d192e0367c803f39e1a7e82ca14a651350aae617e8f01ce94335607c304ac29e7defbd9ca01f596f927224cdecf6c0219010000000000000000000000015aab561b005413ccd4ee99d5020102"
    | "sect233k1" -> "30818c020101301d06072a8648ce3d01023012020200e906092a8648ce3d0102030202014a3006040100040101043d04017232ba853a7e731af129f22ff4149563a419c26bf50a4c9d6eefad612601db537dece819b7f70f555a67c427a8cd9bf18aeb9b56e0c11056fae6a3021e008000000000000000000000000000069d5bb915bcd46efb1ad5f173abdf020104"
    | "sect233r1" -> "3081a8020101301d06072a8648ce3d01023012020200e906092a8648ce3d0102030202014a3022040101041d66647ede6c332c7f8c0923bb58213b333b20e9ce4281fe115f7d8f90ad043d0400fac9dfcbac8313bb2139f1bb755fef65bc391f8b36f8f8eb7371fd558b01006a08a41903350678e58528bebf8a0beff867a7ca36716f7e01f81052021e01000000000000000000000000000013e974e72f8a6922031d2603cfe0d7020102"
    | "sect239k1" -> "30818d020101301e06072a8648ce3d01023013020200ef06092a8648ce3d010203020202009e3006040100040101043d0429a0b6a887a983e9730988a68727a8b2d126c44cc2cc7b2a6555193035dc76310804f12e549bdb011c103089e73510acb275fc312a5dc6b76553f0ca021e2000000000000000000000000000005a79fec67cb6e91f1c1da800e478a5020104"
    | "sect283k1" -> "3081a6020101302506072a8648ce3d0102301a0202011b06092a8648ce3d01020303300902010502010702010c30060401000401010449040503213f78ca44883f1a3b8162f188e553cd265f23c1567a16876913b0c2ac245849283601ccda380f1c9e318d90f95d07e5426fe87e45c0e8184698e45962364e34116177dd2259022401ffffffffffffffffffffffffffffffffffe9ae2ed07577265dff7f94451e061e163c61020104"
    | "sect283r1" -> "3081c9020101302506072a8648ce3d0102301a0202011b06092a8648ce3d01020303300902010502010702010c30290401010424027b680ac8b8596da5a4af8a19a0303fca97fd7645309fa2a581485af6263e313b79a2f504490405f939258db7dd90e1934f8c70b0dfec2eed25b8557eac9c80e2e198f8cdbecd86b1205303676854fe24141cb98fe6d4b20d02b4516ff702350eddb0826779c813f0df45be8112f4022403ffffffffffffffffffffffffffffffffffef90399660fc938a90165b042a7cefadb307020102"
    | "sect409k1" -> "3081cd020101301d06072a8648ce3d010230120202019906092a8648ce3d0102030202015730060401000401010469040060f05f658f49c1ad3ab1890f7184210efd0987e307c84c27accfb8f9f67cc2c460189eb5aaaa62ee222eb1b35540cfe902374601e369050b7c4e42acba1dacbf04299c3460782f918ea427e6325165e9ea10e3da5f6c42e9c55215aa9ca27a5863ec48d8e0286b02337ffffffffffffffffffffffffffffffffffffffffffffffffffe5f83b2d4ea20400ec4557d5ed3e3e7ca5b4b5c83b8e01e5fcf020104"
    | "sect409r1" -> "30820100020101301d06072a8648ce3d010230120202019906092a8648ce3d010203020201573038040101043321a5c2c8ee9feb5c4b9a753b7b476b7fd6422ef1f3dd674761fa99d6ac27c8a9a197b272822f6cd57a55aa4f50ae317b13545f046904015d4860d088ddb3496b0c6064756260441cde4af1771d4db01ffe5b34e59703dc255a868a1180515603aeab60794e54bb7996a70061b1cfab6be5f32bbfa78324ed106a7636b9c5a7bd198d0158aa4f5488d08f38514f1fdf4b4f40d2181b3681c364ba0273c7060234010000000000000000000000000000000000000000000000000001e2aad6a612f33307be5fa47c3c9e052f838164cd37d9a21173020102"
    | "sect571k1" -> "30820113020101302506072a8648ce3d0102301a0202023b06092a8648ce3d01020303300902010202010502010a300604010004010104819104026eb7a859923fbc82189631f8103fe4ac9ca2970012d5d46024804801841ca44370958493b205e647da304db4ceb08cbbd1ba39494776fb988b47174dca88c7e2945283a01c89720349dc807f4fbf374f4aeade3bca95314dd58cec9f307a54ffc61efc006d8a2c9d4979c0ac44aea74fbebbb9f772aedcb620b01a7ba7af1b320430c8591984f601cd4c143ef1c7a30248020000000000000000000000000000000000000000000000000000000000000000000000131850e1f19a63e4b391a8db917f4138b630d84be5d639381e91deb45cfe778f637c1001020104"
    | "sect571r1" -> "3082015a020101302506072a8648ce3d0102301a0202023b06092a8648ce3d01020303300902010202010502010a304d040101044802f40e7e2221f295de297117b7f3d62f5c6a97ffcb8ceff1cd6ba8ce4a9a18ad84ffabbd8efa59332be7ad6756a66e294afd185a78ff12aa520e4de739baca0c7ffeff7f2955727a048191040303001d34b856296c16c0d40d3cd7750a93d1d2955fa80aa5f40fc8db7b2abdbde53950f4c0d293cdd711a35b67fb1499ae60038614f1394abfa3b4c850d927e1e7769c8eec2d19037bf27342da639b6dccfffeb73d69d78c6c27a6009cbbca1980f8533921e8a684423e43bab08a576291af8f461bb2a8b3531d2f0485c19b16e2f1516e23dd3c1a4827af1b8ac15b024803ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe661ce18ff55987308059b186823851ec7dd9ca1161de93d5174d66e8382e9bb2fe84e47020102"
    | _ -> print_supported_named_curve () ; raise UnsupportedNamedCurve ) in
    (ec_explicit_params)
