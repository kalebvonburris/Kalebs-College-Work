class TomFoolery {

	public:
		// Constructors
		TomFoolery(){}

		// Getters
		int getCounter(){return counter;}

		// Operator overrides
		TomFoolery& operator+=(int val) {
			counter += val;
			return *this;	
		}
		
		// Member functions
		void increment() {++counter;}

	private:
		int counter = 1;

};
