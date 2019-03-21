clang -std=c11 -fPIC -c -I../godot_headers rpg.c -o rpg.os
clang -shared rpg.os -o ../bin/librpg.so
