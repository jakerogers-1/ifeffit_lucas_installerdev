       subroutine iff_f1f2(str)
c
c//////////////////////////////////////////////////////////////////////
c Copyright (c) 1997--2000 Matthew Newville, The University of Chicago
c Copyright (c) 1992--1996 Matthew Newville, University of Washington
c
c Permission to use and redistribute the source code or binary forms of
c this software and its documentation, with or without modification is
c hereby granted provided that the above notice of copyright, these
c terms of use, and the disclaimer of warranty below appear in the
c source code and documentation, and that none of the names of The
c University of Chicago, The University of Washington, or the authors
c appear in advertising or endorsement of works derived from this
c software without specific prior written permission from all parties.
c
c THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
c EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
c MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
c IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
c CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
c TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
c SOFTWARE OR THE USE OR OTHER DEALINGS IN THIS SOFTWARE.
c//////////////////////////////////////////////////////////////////////
c
c purpose: look up data in Chantler f' / f'' tables
c arguments:
c      str     command line to performd                 [in]
c
       implicit none
       include 'consts.h'
       include 'keywrd.h'
       include 'arrays.h'
       include 'spline.h'
       include 'atomic.h'
       save
       character*(*)  str
       character*256  path, en_arr, name1, defkey(3)*64
       double precision  a_e(maxpts), tmpx(maxpts)
       double precision  a_f1(maxpts), a_f2(maxpts)
       double precision  ewid, estep, aumax, aumin
       logical   do_f1, do_f2
       integer   jen, jf,  ier, i, k, istrln, ilen
       integer   ndfkey, npts, iret, iz, jdot
       integer  iff_eval, iff_eval_dp, iff_eval_in
       integer  clcalc
       external iff_eval, iff_eval_dp, iff_eval_in
       external istrln, clcalc
c
       call iff_sync
       call gettxt('&install_dir', path)
       do_f1 = .true.
       do_f2 = .true.
       ilen  = istrln(path)
       path  = path(1:ilen)//'/cldata/'
       ilen  = istrln(path) 
       iz    = 1
       estep = zero
       name1 = undef
       do 10 i = 1, maxpts
          a_e(i)  = zero
          a_f1(i) = zero
          a_f2(i) = zero
 10    continue 
c
c note: ewid forced below -0.1d0 signals 'look up core level width'
       ewid = -1.d0

       call bkeys(str, mkeys, keys, values, nkeys)
       ndfkey    = 2
       defkey(1) = 'energy'
       defkey(2) = 'iz'
       do 100 i = 1, nkeys
          k = istrln( keys(i))
          if ((values(i).eq.undef).and.(i.le.ndfkey)) then
             values(i) = keys(i)
             keys(i)   = defkey(i)
          end if
          if ((keys(i).eq.'iz').or.(keys(i).eq.'z'))  then
             ier = iff_eval_in(values(i),iz)
          elseif (keys(i).eq.'group') then
             name1 = values(i)
          elseif (keys(i).eq.'width') then
             ier = iff_eval_dp(values(i),ewid)
          elseif (keys(i).eq.'step') then
             ier = iff_eval_dp(values(i),estep)
          elseif (keys(i).eq.'do_f1') then
             call str2lg(values(i),do_f1, ier)
          elseif (keys(i).eq.'do_f2') then
             call str2lg(values(i),do_f2, ier)
          elseif (keys(i).eq.'energy') then
             en_arr = values(i)
             call lower(en_arr)
          else
             messg = keys(i)(1:k)//' " will be ignored'
             call echo(' *** f1f2: unknown keyword " '//messg)
          end if
 100   continue
c
c get/resolve array names
       if (name1.eq.undef) then
          jdot = index(en_arr,'.')
          if (jdot.ne.0) name1 = en_arr(1:jdot-1)
       endif
       if (name1.eq.undef) then
          call echo( ' f1f2: can''t determine group name')
          return             
       endif
       call fixnam(name1,1)
       call lower(name1)
       jdot = istrln(name1)
       jen  = iff_eval(en_arr, name1, a_e, npts)
       aumax = a_e(1)
       aumin = a_e(1)
       do 160 i = 2, npts
          if (a_e(i).gt.aumax) aumax = a_e(i)
          if (a_e(i).lt.aumax) aumin = a_e(i)
 160   continue 
c      
       if (ewid.lt.-0.1d0) then
          if  ((aumin.le.at_kedge(iz)).and.
     $         (aumax.ge.at_kedge(iz))) then
             ewid = at_kwidth(iz)
          elseif ((aumin.le.at_l3edge(iz)).and.
     $            (aumax.ge.at_l3edge(iz))) then
             ewid = at_l3width(iz)
          elseif ((aumin.le.at_l1edge(iz)).and.
     $            (aumax.ge.at_l1edge(iz))) then
             ewid = at_l1width(iz)
          else
             ewid = zero
          endif
       endif
c       
       if ((npts.ge.1) .and. (iz.ge.4)) then 
          iret = clcalc(iz, path, npts, a_e, a_f1, a_f2)
       endif
c
c  make array of f1
cc       print*, ewid, estep, do_f1,do_f2 , npts, estep
       if (do_f1) then 
          if (ewid.gt.zero) then
             call conv_lor(ewid, npts, a_e, a_f1,estep, tmpx)
             call set_array('f1', name1, tmpx, npts, 1)
          else
             call set_array('f1', name1, a_f1, npts, 1)
          endif
       endif
c
c  make array of f2
       if (do_f2) then 
          if (ewid.gt.zero) then
             call conv_lor(ewid, npts, a_e, a_f2,estep, tmpx)
             call set_array('f2', name1, tmpx, npts, 1)
          else
             call set_array('f2', name1, a_f2, npts, 1)
          endif
       endif
c
       call setsca('core_width',  ewid)
       call iff_sync
c
       return
c end  subroutine iff_f1f2
       end





