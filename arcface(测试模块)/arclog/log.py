import logging
from .logLoader import LogLoader

class Log:
    
    def __init__(self, loggername, logLoader=LogLoader(),debugMode=False,showInScreen = False):
        self.logger = logging.getLogger(loggername)
        if debugMode:
            self.logger.setLevel(logging.DEBUG)
        else:
            self.logger.setLevel(logging.WARNING)
        h = logLoader.handler
        h.setFormatter(logLoader.formater)

        self.logger.addHandler(h)

        if showInScreen:
            s = logging.StreamHandler()
            s.setFormatter(logLoader.formater)
            self.logger.addHandler(s)

