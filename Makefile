OS := $(shell uname -s)

NAME := test.out

#------------------------------------------------#
#   INGREDIENTS                                  #
#------------------------------------------------#
# LIBS        libraries to be used
# LIBS_TARGET libraries to be built
#
# INCS        header file locations
#
# SRC_DIR     source directory
# SRCS        source files
#
# BUILD_DIR   build directory
# OBJS        object files
# DEPS        dependency files
#
# CC          compiler
# CFLAGS      compiler flags
# CPPFLAGS    preprocessor flags
# LDFLAGS     linker flags
# LDLIBS      libraries name

LIBS_TARGET := 
INCS        := include
LIBS		:= readline
INCS		:= $(INCS) /usr/include
LIBS_TARGET := $(LIBS_TARGET)

SRC_DIR     	:= src
SRCS			:= \
				main.c 

SRCS			:= $(SRCS:%=$(SRC_DIR)/%)

BUILD_DIR   := .obj
OBJS		:= $(SRCS:$(SRC_DIR)/%.c=$(BUILD_DIR)/%.o)
DEPS		:= $(OBJS:.o=.d)

ifeq ($(OS), Linux)
	CC          := cc
	CFLAGS      := -Wall -Wextra -Werror -ggdb -O0 -fsanitize=address
	CPPFLAGS    := $(addprefix -I,$(INCS)) -MMD -MP
	LDFLAGS     := $(addprefix -L,$(dir $(LIBS_TARGET)))
	LDLIBS      := $(addprefix -l,$(LIBS))
else ifeq ($(OS), Darwin)
	CC          := cc
	CFLAGS      := -Wall -Wextra -Werror -ggdb -O0 -fsanitize=address
	CPPFLAGS    := -I/Users/$(USER)/.brew/opt/readline/include
	CPPFLAGS	+= $(addprefix -I,$(INCS)) -MMD -MP
	LDFLAGS     := -L/Users/$(USER)/.brew/opt/readline/lib
	LDFLAGS		+= $(addprefix -L,$(dir $(LIBS_TARGET)))
	LDLIBS      := -lreadline $(addprefix -l,$(LIBS))
endif

#------------------------------------------------#
#   UTENSILS                                     #
#------------------------------------------------#
# RM        force remove
# MAKEFLAGS make flags
# DIR_DUP   duplicate directory tree

RM          := rm -rf
MAKEFLAGS   += --silent --no-print-directory
DIR_DUP     = mkdir -p $(@D)

#------------------------------------------------#
#   RECIPES                                      #
#------------------------------------------------#
# all       default goal
# $(NAME)   link .o -> archive
# $(LIBS)   build libraries
# %.o       compilation .c -> .o
# clean     remove .o
# fclean    remove .o + binary
# re        remake default goal
# run       run the program
# info      print the default goal recipe

# Define colors for output
COLOR='\033['
NONE=$(COLOR)0m
GREEN=$(COLOR)32m
GRAY=$(COLOR)37m
RED=$(COLOR)31m
CYAN=$(COLOR)36m
MAGENTA=$(COLOR)35m
BLUE=$(COLOR)34m
ITALIC=$(COLOR)3m
BOLD=$(COLOR)1m
BRIGHT_WHITE=$(COLOR)97m

all: $(NAME)

$(NAME): $(OBJS) $(LIBS_TARGET)
	$(CC) $(CFLAGS) $(LDFLAGS) $(OBJS) $(LDLIBS) -o $(NAME)
	$(info CREATED $(NAME))

$(LIBS_TARGET):
	$(MAKE) -C $(@D)

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c
	$(DIR_DUP)
	$(CC) $(CFLAGS) $(CPPFLAGS) -c -o $@ $<
	$(info CREATED $@)

-include $(DEPS)

clean:
	for f in $(dir $(LIBS_TARGET)); do $(MAKE) -C $$f clean; done
	$(RM) $(OBJS) $(DEPS)

fclean: clean
	$(MAKE)
	$(RM) $(NAME)

re:
	$(MAKE) fclean
	$(MAKE) all

info-%:
	$(MAKE) --dry-run --always-make $* | grep -v "info"

#------------------------------------------------#
#   SPEC                                         #
#------------------------------------------------#

.PHONY: clean fclean re
.SILENT:
