for f in *.pkg
do
  echo "Checking "$f "..."
  pkgutil --check-signature $f
done

for f in *.deb
do
  echo "Checking "$f "..."
  dpkg-sig -c $f
done

for f in *.rpm
do
  echo "Checking "$f "..."
  # find rpm equivalent
done

