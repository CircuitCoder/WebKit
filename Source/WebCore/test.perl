use File::Basename;

my $name = fileparse("C:/Users/CircuitCoder/workspace/WebKit/Source/WebCore/svg/SVGAnimatedInteger.idl", ".idl");

print "$name, $ext\n";
