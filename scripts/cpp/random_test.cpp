#include <iostream>
 
int main() {
	for (int i = 0; i < 10000000; i ++) {
		rand() % 1000000;
	}
}