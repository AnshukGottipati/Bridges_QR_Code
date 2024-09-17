#
#Platform specific variables
#

TARGET =  all


SRCS = qr_code.cpp

OBJS = $(SRCS:.cpp=.o)

EXECUTABLES = $(SRCS:.cpp=)

# Incude and Library paths

BRIDGES_INCL = /root/algo/bridges-cxx-3.4.3-x86_64-linux-gnu/include
RAPID_JSON_INCL = /usr/local/rapidjson/include
CURL_INCL = /usr/local/curl850/include 

CURL_LIB_PATH = /usr/local/curl850/lib 

CURL_LIB = curl
LOCAL_LD_FLAGS = -L/root/algo/bridges-cxx-3.4.3-x86_64-linux-gnu/lib



# Include and library flags

IFLAGS = -I$(BRIDGES_INCL)  -I$(CURL_INCL)  -I$(RAPID_JSON_INCL) -DTESTING=1
LDFLAGS =  -L$(CURL_LIB_PATH) $(LOCAL_LD_FLAGS)
CXXFLAGS = -g $(IFLAGS) -std=c++14 $(LOCALCXXFLAGS)

# Libraries

LIBS = -l$(CURL_LIB) $(LDFLAGS) -l pthread -l bridges -l pthread

ASSIGNMENTIDSTART=1000
ASSIGNMENTIDTEST=1099

.SUFFIXES: .cpp .o

%: %.cpp
	$(CXX) -g -o $@ $< $(CXXFLAGS) $(LDFLAGS) $(LIBS)

.o:
	$(LD) $(LDFLAGS)  $< -o $@ $(LIBS)

.cpp.o:
	$(CXX) -c -g -o $@ $< $(CXXFLAGS)


all : $(EXECUTABLES)

run: $(EXECUTABLES)
	ASSIGNMENTID=$(ASSIGNMENTIDSTART) ; for BINARY in $(EXECUTABLES); do \
		echo FORCE_BRIDGES_FRAMELIMIT=10 ./$$BINARY $$ASSIGNMENTID $(BRIDGES_TESTING_USER_NAME) $(BRIDGES_TESTING_API_KEY) $(BRIDGES_SERVER) ; \
		     FORCE_BRIDGES_FRAMELIMIT=10 ./$$BINARY $$ASSIGNMENTID $(BRIDGES_TESTING_USER_NAME) $(BRIDGES_TESTING_API_KEY) $(BRIDGES_SERVER) ; \
		ASSIGNMENTID=`expr $$ASSIGNMENTID + 1`; \
	done

run_%: %
#That FORCE_BRIDGES_FRAMELIMIT stops the game assignment after 10 frames
	FORCE_BRIDGES_FRAMELIMIT=10 ./$(subst run_,,$@) $(ASSIGNMENTIDTEST) $(BRIDGES_TESTING_USER_NAME) $(BRIDGES_TESTING_API_KEY) $(BRIDGES_SERVER)

run_valgrind_%: %
#That FORCE_BRIDGES_FRAMELIMIT stops the game assignment after 10 frames
	FORCE_BRIDGES_FRAMELIMIT=10 valgrind ./$(subst run_valgrind_,,$@) $(ASSIGNMENTIDTEST) $(BRIDGES_TESTING_USER_NAME) $(BRIDGES_TESTING_API_KEY) $(BRIDGES_SERVER)


clean:
	rm -f $(EXECUTABLES) $(OBJS)

test_clean:
	-rm *.cpp *.hpp .h $(OBJS)

depend: $(SRCS)
	gcc -MD  $(IFLAGS) $(SRCS)

backup:
	tar cvfz bridges_cxx.tgz  src docs Makefile 
	cp bridges_cxx.tgz ~/Dropbox/.


# DO NOT DELETE
