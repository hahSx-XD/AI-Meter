import os
import logging
from logging import handlers


class LogLoader:
    def __init__(self, handler=None, formater=None):
        if not handler:
            self.handler = self._getDefaultHandler()
        else:
            self.handler = handler
        if not formater:
            self.formater = self._getDefaultFromater()
        else:
            self.formater = formater

    def _getDefaultHandler(self):
        if not os.path.exists('logs'):
            os.mkdir('logs')
        t_handler = handlers.TimedRotatingFileHandler(filename='logs/log', when='M')
        t_handler.suffix = '%Y%m.log'
        return t_handler

    def _getDefaultFromater(self):
        t_format = logging.Formatter(
            '%(asctime)s %(levelname).1s %(message)s',
            '%Y-%m-%d %H:%M:%S')
        return t_format
