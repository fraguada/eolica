#define SECRET_SSID "CDG_DRAWBOT"
#define SECRET_PASS "dbotcdg17"

// the IP address for the remote:
//const IPAddress remoteip(192, 168, 0, 101);
const IPAddress remoteip(255,255,255,255); //broadcast
const int remoteport = 6000;

// DATA FOR LOCAL MKR1000

//NODE 0
#define deviceAddress "/eolica/0"
const IPAddress localip(192, 168, 0, 100);
const unsigned int localport = 4000;      // local port to listen on

//NODE 1
//#define deviceAddress "/eolica/1"
//const IPAddress localip(192, 168, 0, 102);
//const unsigned int localport = 4001;      // local port to listen on



