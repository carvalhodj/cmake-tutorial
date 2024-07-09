#!/bin/sh

# Display usage
cpack_usage()
{
  cat <<EOF
Usage: $0 [options]
Options: [defaults in brackets after descriptions]
  --help            print this message
  --version         print cmake installer version
  --prefix=dir      directory in which to install
  --include-subdir  include the Tutorial-1.0-Linux subdirectory
  --exclude-subdir  exclude the Tutorial-1.0-Linux subdirectory
  --skip-license    accept license
EOF
  exit 1
}

cpack_echo_exit()
{
  echo $1
  exit 1
}

# Display version
cpack_version()
{
  echo "Tutorial Installer Version: 1.0, Copyright (c) Humanity"
}

# Helper function to fix windows paths.
cpack_fix_slashes ()
{
  echo "$1" | sed 's/\\/\//g'
}

interactive=TRUE
cpack_skip_license=FALSE
cpack_include_subdir=""
for a in "$@"; do
  if echo $a | grep "^--prefix=" > /dev/null 2> /dev/null; then
    cpack_prefix_dir=`echo $a | sed "s/^--prefix=//"`
    cpack_prefix_dir=`cpack_fix_slashes "${cpack_prefix_dir}"`
  fi
  if echo $a | grep "^--help" > /dev/null 2> /dev/null; then
    cpack_usage
  fi
  if echo $a | grep "^--version" > /dev/null 2> /dev/null; then
    cpack_version
    exit 2
  fi
  if echo $a | grep "^--include-subdir" > /dev/null 2> /dev/null; then
    cpack_include_subdir=TRUE
  fi
  if echo $a | grep "^--exclude-subdir" > /dev/null 2> /dev/null; then
    cpack_include_subdir=FALSE
  fi
  if echo $a | grep "^--skip-license" > /dev/null 2> /dev/null; then
    cpack_skip_license=TRUE
  fi
done

if [ "x${cpack_include_subdir}x" != "xx" -o "x${cpack_skip_license}x" = "xTRUEx" ]
then
  interactive=FALSE
fi

cpack_version
echo "This is a self-extracting archive."
toplevel="`pwd`"
if [ "x${cpack_prefix_dir}x" != "xx" ]
then
  toplevel="${cpack_prefix_dir}"
fi

echo "The archive will be extracted to: ${toplevel}"

if [ "x${interactive}x" = "xTRUEx" ]
then
  echo ""
  echo "If you want to stop extracting, please press <ctrl-C>."

  if [ "x${cpack_skip_license}x" != "xTRUEx" ]
  then
    more << '____cpack__here_doc____'
This is the open source License.txt file introduced in
CMake/Tutorial/Step9...

____cpack__here_doc____
    echo
    while true
      do
        echo "Do you accept the license? [yn]: "
        read line leftover
        case ${line} in
          y* | Y*)
            cpack_license_accepted=TRUE
            break;;
          n* | N* | q* | Q* | e* | E*)
            echo "License not accepted. Exiting ..."
            exit 1;;
        esac
      done
  fi

  if [ "x${cpack_include_subdir}x" = "xx" ]
  then
    echo "By default the Tutorial will be installed in:"
    echo "  \"${toplevel}/Tutorial-1.0-Linux\""
    echo "Do you want to include the subdirectory Tutorial-1.0-Linux?"
    echo "Saying no will install in: \"${toplevel}\" [Yn]: "
    read line leftover
    cpack_include_subdir=TRUE
    case ${line} in
      n* | N*)
        cpack_include_subdir=FALSE
    esac
  fi
fi

if [ "x${cpack_include_subdir}x" = "xTRUEx" ]
then
  toplevel="${toplevel}/Tutorial-1.0-Linux"
  mkdir -p "${toplevel}"
fi
echo
echo "Using target directory: ${toplevel}"
echo "Extracting, please wait..."
echo ""

# take the archive portion of this file and pipe it to tar
# the NUMERIC parameter in this command should be one more
# than the number of lines in this header file
# there are tails which don't understand the "-n" argument, e.g. on SunOS
# OTOH there are tails which complain when not using the "-n" argument (e.g. GNU)
# so at first try to tail some file to see if tail fails if used with "-n"
# if so, don't use "-n"
use_new_tail_syntax="-n"
tail $use_new_tail_syntax +1 "$0" > /dev/null 2> /dev/null || use_new_tail_syntax=""

extractor="pax -r"
command -v pax > /dev/null 2> /dev/null || extractor="tar xf -"

tail $use_new_tail_syntax +152 "$0" | gunzip | (cd "${toplevel}" && ${extractor}) || cpack_echo_exit "Problem unpacking the Tutorial-1.0-Linux"

echo "Unpacking finished successfully"

exit 0
#-----------------------------------------------------------
#      Start of TAR.GZ file
#-----------------------------------------------------------;
� ��Kf �]tSǙ����/hyp�B I~`h	##Ǐ�I�\dI��Ȓ���B��iN\/�7�MIʶn6��ז��fi��cB����t7���So���m�G�IZ��?wF�;����t����3��?�{��㿡`�J�}v�cUY�Թ���Ӥ����.ת��rW��p�JV�$���V]<�z����B����H�?���_�Wm���}j0�ٽ���Gyi�i����\��@��;P���U�������F}��孔��1�ڡ�KJ��<c��a�mΒhI��%��vFU�_Z)��ƹ\)������GV��t�c�����U�$~ʽ��j�$��"�&YʦΚ�����|�������L�Es��>�D��(<8�N�6UU���n��t��,���N��p�:J�������˄����e0������R~���,�Ŗk�s�!��Cw�[_X���� �LQ���	#?�AI\	�+8�:JW���HȤ*�̛�d�r@�C��h���r����)n�����vu���jT���*y�j�[��~���-��d�E::a��5`�:Yw���o���Hg ���Jk�����/�a>�t�����\��k$�\*���򬣲���%�	��1�WL�V*s����,��n���v]`���-	m�^JE�ľ�Be��QZ1M|̧Q��_�4����F7Ji7�s$�������C���_'�b��5�?B�OM��J�?�����n�D��]�=��v�W^�p	㿲2�#=��n�㿲
��o?��>��-���<�%��.`W�p\�(��v[I��8���8�;�Z��`k�J��h.^��	��,*v�B�qzU\��!ؑ��eR�}�k�g�<�ǒW�����7_c_bv�g�g߼_-�dXI���g;JR�T��D�J��-z���!*��#dL
\�D*��K"�¿ff�\���aL{��i=��Hb���*�N�n����gϙܢGK`�F�>qtr-���wr�ן8����=��{�X�=�H�7�c����\���m�'o|��'�eV+i��@�V�RN%���j;���jDn�:��`�/{�r0T�ސ����T�茫�p��Q���Fi/�Ţ�O��+�|��(?�n���1�ߍ��h���e���Ŏ�5<s�OdeJN.�u��(�7�?J�o�K8�H�#�)}Aҿ}즗���9g�;-��&��&�ߚ����}j��h7����j�-UԈ�k�FcJ0��ñ`[8௹����(e�Ҡ���HLi��JH{�+�+����w��R_$���P��Au:1QE�z�j���v�V	}J^�ގ_��n(S��$e����oU�WW7������Mn ���.L"�t��r��G$s�U�7Dw�c���j�G����� ����p��y��qxű/��� ŗ����U.|!�?���������
���=~��9����X��^��.A�G���&rn7��l1.�/��諒�G#��~��-ܢ/���A���9�Ž��x�.�����WR���_��w
���[-�<B�O7{��@'tO_�������A
L7{p�d��S�n� [�Q�Odk��3��t�ŴB����?� ���A�F�~��k6{PLR<={0�.�������x��%��U�����X����g5�i�N���Q�j�����s�3=�s9܇;�޶�	�yya��:�����˟��G��:�������������Sg �.ɱ��W#Ѡ7T	��f�0m�//O���� PRZ����í\I&�|���р_�tj}��˱���c1�5�Y���?���r���lߦԮ߼�^vN�fp�o�0������a��n�~�1u��;\N���W�t��]'����*Z�_I�!n�R��
��"�z2k��>���b0�fl4���/R6k�(?k�1U��
�8��i��{����Hz�1
�p����l��j|�����Yi�o�VO��z�ʓ퍪�rEZ)�����FIO�������WG����7%=e����ҩ[�����C�UOY;�M�+C��`8޽���|Ey�=���z���U��Ҕ�z�^�J��������Dh��l|yAp��\���4����?�-K����e�a��?��챵������k�]����o4�'2���-��I�e3�C&x�I�	�|�	�y�֤|�2�W������j�tGL�|Ǥ|,&�3Lҽ�_l�/l��~�$�ߙȷ��Yh��&��C2��	���5��vĠ�s��٥?�uPEi누��")5���?�cj �X[��t���}p�v������N�K[���Qx�2Z�l����DiP|��]����W��װJ���U
��U� f��8A������]�nQ�]/u���ur�N�F�>�����jT*��倗��Q������VQ�m��w������J0����7�ǵ?�=y�x��rh��Jg ��A��K�r��-��2��5�����R�L*a5�HR��������Բ=�^R���
���v�p:���H,@0����`�%ҪD���������!����Y"�HH	D�����p)�C�����U��}����gM��a�R�A���Kָ�s����$\*���@��7�v��ux�����Jk���GHvp�7��T�o�r#�#ۑ�j�(���4|SU�RbwHU���7�(N{��ik�`.���xV��rj��bpU��t�q��
c++�e���2`�f�Wb�r�0:̀'P.��W6�_{.Y�͙��\ݒ]spTגɞ[���㎑���L��G�_��i���-����!��$�6�?)�&5g�Ư���}�b���ǳp��5��s1�ߥ�ٸ�������~wP|�N�3��v�☒_�=����A���8|�s��~��������C��ں���su�9�m�ɖ�+�9ί�s8?�^���{��������|��rx�������px!��qx�7s8��m����v��W�~%�ws�<����9�_�������s�5>�������HJ��K��K��K��K��K��K����ro]����L��/��JI�|fP�&�==?��i&�~p��ѢJ�B�l��87=�<N�������� ��y�B;D��#�S)c�
y���'������^�?�<���u�������y�:�#�����X%����Ә���!�S*c2���U;N���.�q
eL"|=�8u26~�����~�sI�	��+H�	�B�J��/C~�?�oD~>�?�X���������kOϫ�u�n��g�����?�.Io�ڋiK���\INc�<�'��P�gWhU��)Z���¯'��PO�-�=��#�[�92a�X�yN�W灀S9��֢ES�Q��k���w���ӳ�>���}M-�������� �� o�2�@"�{���=ښ������� ,�n���޻瀧7����eܴ��v�:{��}�E�����>zpy�];���?&�!劂�!� h���Y9�B�!��o�S�&�/���|#���.��=L�K��v&u�O�p���ڔл 9L�˯H}�����'�z�'�x�5=���1ư��Lj���z�>	����G��*�Ҏ����j����L�?�9�Z�B��/`:�<�}{2?�R���d�CɀK�<�'���m��F����HM��NWzz�2��x/�8m� ���m�u�)}���v������G�G�ŐD�9�,2yz�L��
��A�-3��� ��qH���.4�q�}�{,��#����iy��|b�VVx ���~f? $���s�s�=��������-�ܯcA�"B-P���ii>�ɞq�C��g_���(�JI��'�M$��Q����00�I_��5`8�3��QϻXdM}W�Ӭ3\ᑞ�CY��6���]�~�ߑ@q����c���<q��0��g��`\�+����/M���_�����9Բg�F���сяk�Mz��L�&��q���j����OϞ���,G�B<��ha���g�9~^��_/��]k�$�S��1�a���0�!������S��E��(X�:�uE+���0�D��;�mD�`�P}��jԎ`Ϟa)^M-[`С	R�x�&�P1�a�5��jX�J�&����B�M�6�e.o���E�b�/zV�x������!���dO�k��Sܯy��kH�	�G��[�دHe�i�s���r�M���J{�{�"PlXt=E]�<�j�;�}�J��7�:�az���;��8�^t:W��\�zL��f���~�G�~�Vt�%�~	���az+�E��!�kRi� O�߸c�`�715g%���X0y%��`�Ro��3�=�ܬ��/�%w��ݔ��8��g��ǖ\��`�EX0٘5��әLcu���߳jMY0y�,{����|�MLY0Q��,Nf�[�ЂIrܜ)�]ڥ]��y9����?��h,	˒]j�y�kdI�;ZQ��Oƽр�D���`L�r��Ik���<��t��P��!*�zG�+]nkM�kl�����x=�:0�H}�D��oo%9@_zK�~��6<�n�65�t�+@ǁ��!���� ��H3P|�t]
��������N����I���~�$@_ �N7ݘY�B��CЂ��1�l�G�t��]"щERX\]�`sќr�J�~dY�b������L$ȾfM�Z�%�����U�w��)��;��y��)MﺭD��/���k������P�.(��8�d�{l��V"�d��coRK:,�՟�ǽɯ��ͼKJ������~�?�ż��u�����,�d�
zn�$��&�C�X��QRr�Ѷ4�yZ��c}<�������˹;�?���o��[)���!�ߤ�c= ���-�d|�H��2��,�'-����0
�y#������ͬ�%���b�zҚ9a��a�������S�c�o��X3	���d�E�;��Ii�vi�vi�vi�v�_ۯ��糑�3S�W
�f�o�|r︬�g�b�F��{vn���f{�ٞkv~�Z�������}��	X@7����ԟ��ٙ ������=�����|v��������x�.��-ӂb{�Y��%�����)/��	�3��)��9������qѕ����J[)���aJ����>K�1J_���)=Ki�'�!J�PZNi5�wP�Ji��`�?s����n��LO��c���l����K:R�Э��'\��n�D���Iw�$�&��D�%�?"��&��3��C����$�;sg%�s�W��k��]v?Ѭ=_-Uܮ"o�WK�B{��r^�I�o�x��/N�{`g��������<q�ɹ������I��/�zi$��d�:<�l�zR�Xf���A�\F��s�/��Wehr����@�7@��|��~��\����rĭE��s�L-�4]v{��DNW�������f��&��,M�s�5����o��zK?����YYB�lc�&x�	��l�t����B�-�N}[���GM��&x�˚?�p~~����� �X�������*Wӿ��k��?���w�_�;�J��z��T�[����y�����L�C�i��ej^��9��<-�J!�ߧ�'h����y������C�I���1���I�_���k��h�eV����������G���E�c�\��9��X��M¯/��s�4B�3_�����w�D��B�炤R�Yl{������@����(���k݊gc��l�s��ښ*3��©�J��5Q�Y�(���7D�D�5>z�?@��+wݵm�����x����G�5~�o���nt(uՍJݖF�RW�P�l�lt)n4Q��u4�V�ۜN�����$�l)�`X���YN�j�
fb��R�GT
g��'�uU����A�!�����������AR�����ʕMq@7��e�)�}����Ie~�3�Ji����@���*�,�ט�Us��&�&b�^)&�
�t�CD;��J����/^�V��u�ɷ�K62�T/�ƏQ-�J|0���U%���^5������1BM����̤N��߹�jfeV
](��3E/���v�$C?��;S��#zS1�)�+�h����Fe��tFx��0��s���Y���:�VqH�jw��gc��P��L�W9�p��n?(��֢��YG�i���`�:ÁS�Iff�H,���*-��%_p���n���-Cw]ǔ��*+>F��J����*�%V$�E�/�����"U2sD�`
ˠw^B����q����ƼS��y�,��
0,~�cc�{�8�1�����o_n�����P�����JB-�`ȿ"�t���A�ڽ�v����$4�F5�.m��Q���W�^u�T���Zd�����L��8ꃑb�/Щ*d۟&�Q�.M����AD��䟖����/���%$3{�̉;�>,�mG���eN��S�_�ûX/�@����<M����l"a��z�t�$��'��2���1ꠔ���"��6.>[?dt�76&M.����6���8F��b��U�����\|���(��w����6s�$�LY|���([oˏ��4>�![�d��wf�8b��H�W�d=�mdI���? ėe=�
�X���ټ6�y�f�4�����~F���ߑ�/�	v�ǅ�b�='�7�Km��	!��SO_>�&��s!��R=��^l��I�Z[wNڹ^k�^�@ߐ4�p,>[�����(�m&�����f�X;Ȳ�B���+�f_�ct������C�ğ'�g�������v��� �y�
:��@��J!�"��WY|��Z��W��i�Z�>���B��WA?��^����g����it�!��7��.���O��pT�L �  