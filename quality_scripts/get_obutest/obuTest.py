#!/usr/bin/env python

################################################################################
#
# Copyright (c) 2019 Baidu.com, Inc. All Rights Reserved
#
################################################################################

import logging
import os
import random
import subprocess
import sys
import time
import pexpect


local_path = ''
obu_ip = '192.168.10.21'
obu_user = 'root'
obu_pass = '*Ctfo002373*'
log_file = './obuTest.log'
#try:
#    os.remove(log_file)
#except:
#    pass

logging.basicConfig(level=logging.DEBUG,
                    filename=log_file,
                    datefmt='%Y/%m/%d %H:%M:%S',
                    format='%(asctime)s [%(levelname)s] %(message)s')
logger = logging.getLogger(__name__)


def sshRun(cmd, host=obu_ip, user=obu_user, passwd=obu_pass, timeout=30, ifread=False, ifkill=False, run=20):
    """ssh run command.

    Args:
        cmd
        ip
        user
        passwd
        timeout
        ifread
    Returns:
        None
    Raises:
        Exception
    """

    sshcmd = 'ssh -o ServerAliveCountMax=1 -o ServerAliveInterval=10 -o ConnectTimeout=5 %s@%s %s' % (user, host, cmd)
    out = b''
    logger.info(sshcmd)
    child = pexpect.spawn(sshcmd, timeout=timeout)
#    fout = os.open(logfile, 'wb')
#    child.logfile = fout
    i = child.expect(['yes/no', 'password: '])
    if i == 0:
        child.sendline('yes')
        child.expect(['password: '])
    child.sendline(passwd)

    if ifkill:
        time.sleep(run)
        child.sendeof()

    i = child.expect([pexpect.EOF, pexpect.TIMEOUT])
    
    if ifread:
        out = child.before
    child.close()

#    if 0 != child.exitstatus:
#        raise Exception('Wrong ssh')
    return out.strip()

def is_obu_alive(timeout=60):
    """if obu alive

    Args:
        timeout
    Returns:
        True/False
    Raises:
        None
    """

    for i in range(0, timeout):
        try:
            subprocess.check_call('ping %s -c 1' % obu_ip, stdout='/dev/null', shell=True)
            logger.info('OBU is online')
            return True
        except:
            time.sleep(1)
    else:
        logger.info('OBU is not online')
        return False

def test(control):
    """test

    Args:
        None
    Returns:
        0/-1
    Raises:
        None
    """

    subprocess.Popen('ssh-keygen -R %s' % obu_ip, shell=True)
   
    if control == 'start':
#        try:
#            os.remove(log_file)
#        except:
#            pass 
        v2x_pid = sshRun('pidof v2x', ifread=True)

        if len(v2x_pid.strip()) != 0:        
            sshRun('kill -9 '+ v2x_pid.strip())

        lte = sshRun('"/opt/v2x/bin/lte-test &"', ifread=True, ifkill=True)
        logger.info(lte)
        return 0
    elif control == 'stop':
        test_pid = sshRun('pidof lte-test', ifread=True)
        if len(test_pid.strip()) != 0:
            sshRun('kill -9 '+ test_pid.strip())
    else:
        with open(log_file, 'r') as f:
            lines = f.readlines()
            for line in lines:
                if 'OBU is online' in line:
                    logger.info('OBU connective test PASS.')
                if 'rxLen' in line:
                    logger.info('OBU V2X test PASS.')
                    print "SUCCESSED"
                    return 1
            else:
                logger.info('OBU connective test FAIL.')
                return 0  
           
if __name__ == '__main__':

    if not is_obu_alive():
        sys.exit(-1)
    
    try:
        ret = test(sys.argv[1])
        logger.info('test %d' % ret)
    except:
        logger.error('test failed')
    sys.exit(0)
