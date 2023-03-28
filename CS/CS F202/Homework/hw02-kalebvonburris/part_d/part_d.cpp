#include <iostream>
#include <string>
#include <fstream>

using std::cerr;
using std::cout;
using std::string;
using std::endl;
using std::fstream;
using std::getline;

int main (int argc, char** argv) {
	if (argc != 2) {
		cerr << "Usage: ./part_d input.txt" << endl;
		return 1;
	}

	string program_name{argv[0]};
	string input_filename{argv[1]};

	fstream file;

	try {
		file.open(input_filename, std::ios::in);
	}
	catch(...) {
		cerr << "File " << program_name << " not found. Usage: ./part_d input.txt" << endl;
		return 2;
	}
	
	string iline;

	while (file) {
		getline(file, iline);
		cout << iline << "\n";
	}

	file.close();

	return 0;
}