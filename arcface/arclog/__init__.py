from logging import Formatter, handlers
from .logLoader import LogLoader
from .log import Log


class MLogLoader(LogLoader):

    def __init__(self):
        # If maxBytes is zero, rollover never occurs.
        self.handler = handlers.RotatingFileHandler(filename='logs/log', maxBytes=0, backupCount=10000)
        self.formater = Formatter('%(asctime)s %(message)s')


class ageLogLoader(LogLoader):

    def __init__(self):
        self.handler = handlers.RotatingFileHandler(filename='logs/age', maxBytes=0, backupCount=10000)
        self.formater = Formatter('%(message)s')


class genderLogLoader(LogLoader):

    def __init__(self):
        self.handler = handlers.RotatingFileHandler(filename='logs/gender', maxBytes=0, backupCount=10000)
        self.formater = Formatter('%(message)s')


class livenessLogLoader(LogLoader):

    def __init__(self):
        self.handler = handlers.RotatingFileHandler(filename='logs/liveness', maxBytes=0, backupCount=10000)
        self.formater = Formatter('%(message)s')


class scene1LogLoader(LogLoader):

    def __init__(self):
        self.handler = handlers.RotatingFileHandler(filename='logs/scene1', maxBytes=0, backupCount=10000)
        self.formater = Formatter('%(message)s')


class scenenLogLoader(LogLoader):

    def __init__(self):
        self.handler = handlers.RotatingFileHandler(filename='logs/scenen', maxBytes=0, backupCount=10000)
        self.formater = Formatter('%(message)s')


"""
usage: 
    from arclog import logger
    logger.info('info')
    logger.debug('debug')
"""
logger = Log(loggername="logger", debugMode=True, logLoader=MLogLoader(), showInScreen=False).logger
genderlogger = Log(loggername="gender", debugMode=True, logLoader=genderLogLoader(), showInScreen=False).logger
agelogger = Log(loggername="age", debugMode=True, logLoader=ageLogLoader(), showInScreen=False).logger
livenesslogger = Log(loggername="liveness", debugMode=True, logLoader=livenessLogLoader(), showInScreen=False).logger
scene1logger = Log(loggername="scene1", debugMode=True, logLoader=scene1LogLoader(), showInScreen=False).logger
scenenlogger = Log(loggername="scenen", debugMode=True, logLoader=scenenLogLoader(), showInScreen=False).logger
