#include <stdio.h>

// Bison tarafından tanımlanacak olan parse fonksiyonu
int yyparse(void);

int main() {
    yyparse();  // Parser'ı başlat
    return 0;
}
