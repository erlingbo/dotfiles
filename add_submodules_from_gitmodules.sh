git config -f .gitmodules --get-regexp '^submodule\.' | perl -lane'
$conf{$F[0]} = $F[1]}{
@mods = map {s,\.path$,,; $_} grep {/\.path$/} keys(%conf);
sub expand{$i = shift; map {$conf{$i . $_}} qw(.path .url .branch)}
for $i (@mods){
    ($path, $url, $branch) = expand($i);
    print(qq{rm -rf $path});
    print(qq{git submodule add --force $branch $url $path});
}
'
