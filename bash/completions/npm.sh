#!/bin/bash

if _command_exists npm; then
  eval "$(npm completion)"
fi
