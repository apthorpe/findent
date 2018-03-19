#!/bin/sh
. ./prelude
cat <<eof > prog1.f || exit 1
program prog1
continue
end program prog1
eof
cat << eof > prog2.f || exit 1
module modprog2
integer i
end module
program prog2
use modprog2
continue
end program prog2
eof
cat << eof > prog1.f.ref || exit 1
program prog1
     continue
end program prog1
eof
cat << eof > prog2.f.ref || exit 1
module modprog2
     integer i
end module
program prog2
     use modprog2
     continue
end program prog2
eof

echo "testing wfindent"
echo "WFINDENT: $WFINDENT"
echo "FINDENT: $FINDENT"
$WFINDENT -i5 prog1.f prog2.f
sed -i 's/\r//' prog1.f
sed -i 's/\r//' prog2.f
for i in 1 2 ; do
   cmp -s prog$i.f prog$i.f.ref
   if [ $? -ne 0 ] ; then
      echo "prog$i.f and prog$i.f.ref are not equal"
      exit 1
   fi
done

exit 0

