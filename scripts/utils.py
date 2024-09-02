import logging

def setup_logging():
    logging.basicConfig(level=logging.INFO)
    return logging.getLogger(__name__)

def some_utility_function():
    pass  # Placeholder for utility functions
