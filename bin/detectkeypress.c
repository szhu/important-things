/* 2>/dev/null
COMPILED=${0%.*}
[[ -e "$COMPILED" ]] || clang $0 -o "$COMPILED" -framework Carbon
exec "$COMPILED" $@
*/

#import <Carbon/Carbon.h>

int main(int argc, const char *argv[])
{
    unsigned int modifiers = GetCurrentKeyModifiers();
    if (argc == 1)
        printf("%d\n", modifiers);
    else
    {
        int i, result = 1;
        for (i = 1; i < argc; ++i)
        {
            if (0 == strcmp(argv[i], "shift"))
                result = result && (modifiers & shiftKey);
            else if (0 == strcmp(argv[i], "option"))
                result = result && (modifiers & optionKey);
            else if (0 == strcmp(argv[i], "cmd"))
                result = result && (modifiers & cmdKey);
            else if (0 == strcmp(argv[i], "control"))
                result = result && (modifiers & controlKey);
            else if (0 == strcmp(argv[i], "capslock"))
                result = result && (modifiers & alphaLock);
        }
        printf("%d\n", result);
    }
    return 0;
}
