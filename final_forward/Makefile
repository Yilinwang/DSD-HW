CXX=g++
CXXFLAGS=-std=c++11
.PHONY: clean remake test_run

sdt: sdt.o qm.o
	$(CXX) $(CXXFLAGS) sdt.o qm.o -o sdt
sdt.o: state_diagram_translator.cpp qm.o
	$(CXX) $(CXXFLAGS) -c state_diagram_translator.cpp -o sdt.o
qm.o: quine_mc_cluskey.cpp
	$(CXX) $(CXXFLAGS) -c quine_mc_cluskey.cpp -o qm.o
clean:
	rm *.o sdt
remake:
	make clean
	make
test_run:
	./sdt < test.in
