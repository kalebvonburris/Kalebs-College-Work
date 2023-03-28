#include <iostream>
#include <string>
#include <climits>
#include "TomFoolery.h"

using namespace std;

int main() {
	TomFoolery a{};
	cout << "Let's reach an integer overflow!" << endl;
	cout << "Input numbers until they sum to > " << INT_MAX << endl;
	cout << "I swear, nothing funny will happen..." << endl;

	int val = 0;

	while (a.getCounter() > INT_MIN) {
		cout << "Sum is: " << a.getCounter() << ", Input a number: ";
		cin >> val;
		a += val;
		cout << "\r\r";
	}
}