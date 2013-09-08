#ifndef SEMITCP_H
#define SEMITCP_H

class SemiTcpAgent;
class AODV;
class DeferSendTimer;
#define MAXHISTORY	200
#include <stdio.h>
#include <list>
#include <algorithm>
#include <stdlib.h>
#include <sys/types.h>
#include <aodv/aodv.h>
#include "ip.h"
#include "tcp.h"
#include "flags.h"
#include "scoreboard.h"
#include "scoreboard-rq.h"
#include "random.h"
#include <mac/mac-802_11.h>
#define TRUE    1
#define FALSE   0
#define RECOVER_DUPACK  1
#define RECOVER_TIMEOUT 2
#define RECOVER_QUENCH  3
class Mac802_11;

//#define TCPDEBUG

class DeferSendTimer : public Handler
{
protected:
        int busy_;
        Event intr;
        SemiTcpAgent *a_;
public:
        DeferSendTimer ( SemiTcpAgent *a ) {
                busy_ =  0;
                a_ = a;
        }
        inline int busy ( void ) {
                return busy_;
        }
        void start ( double time ) {
                Scheduler &s = Scheduler::instance();
                assert ( busy_ == 0 );
                busy_ = 1;
                s.schedule ( this, &intr, time );
#ifdef TCPDEBUG
                printf ( "%10.9f DeferSendTimer::%s time:%.9f\n", Scheduler::instance().clock(), __FUNCTION__, time );
#endif
        }
        void stop ( void ) {
                Scheduler &s = Scheduler::instance();
                assert ( busy_ );
                s.cancel ( &intr );
                busy_ = 0;
        }
        void handle ( Event * );
};

class SemiTcpAgent : public TcpAgent
{
        friend class DeferSendTimer;
public:
        SemiTcpAgent();
        void send_down ( bool force = false );
        int command ( int argc, const char*const* argv );

private:
        virtual void recv ( Packet *pkt, Handler* );
        void reset();
        virtual void timeout ( int tno );
        virtual void output ( int seqno, int reason = 0 );
        void recv_newack_helper ( Packet *pkt );
        void newack ( Packet* pkt );
        virtual void send_much ( int force, int reason, int maxburst );
        void set_rtx_timer();

        Mac802_11* p_to_mac;

        void handleDeferSendTimer();
        DeferSendTimer defer_send_timer_;

        list<int> seqnolist; //the list of the packets needed to be retransmitted
        void reset_rtx_timer ( int backoff );
///SEMIAP: imported from TCP-AP
        int use_ap_;
        void calc_variation();		/* Calculate variation of the n_hop_delay_ samples
						   (equivalent to the variation of the RTT samples
						   since n_hop_delay_ is simply a fraction of RTT) */

        int n_factor_;				/* Spatial reuse constraint factor which mainly
						   depends on ratio between transmission range
						   and interference range (default is 4 for 250m
						   transmission range and 550m interference/cs ranges) */
        int samplecount_;
        int history_;				/* n_hop_delay_ samples history size */
        double delaybound_;			/* An upper bound for the n_hop_delay_ samples */
        double rate_interval_;			/* time between successive packet transmissions */
        double n_hop_delay_;			/* How much to delay the transmission to avoid hidden
						   terminal induced collisions */
        double avg_n_hop_delay_;
        double avg_queuing_delay_;
        double alpha_;				/* smoothing factor for avg_n_hop_delay_ */
        double gamma_;				/* smoothing factor for avg_queuing_delay_ */
        double samples[MAXHISTORY];		/* n_hop_delay_ samples */
        double adev_;				/* mean absolute deviation n_hop_delay_ samples */
        double ll_bandwidth_;			/* link layer bandwidth (in bits/s) */
///End SEMIAP
        list<int> unacked; //a list of the unacked TCP seqences
};
#endif
