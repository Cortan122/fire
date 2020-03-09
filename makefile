#
# fire: the pre-cambrian DOOM animation in the terminal
# (c) Kied Llaentenn
# See the LICENSE for more information
#

NAME	= fire
WARNING	= -Wall -Wextra -pedantic -Wmissing-prototypes \
	  -Wold-style-definition -Werror

INC	= -Isub/termbox_next/src

CC	= gcc
CFLAGS	= -std=c99 -O3 $(WARNING) $(INC)
LDFLAGS	=

TRMBOX	= sub/termbox_next/bin/termbox.a
SRC	= main.c draw.c
OBJ	= $(SRC:.c=.o)

DESTDIR = /
PREFIX	= /usr/local/

all: $(NAME)

clean:
	rm -f $(NAME) $(OBJ)

.c.o:
	@echo "\tCC\t\t$@"
	@$(CC) $(CFLAGS) -c $<

$(TRMBOX):
	@echo "\tCC\t\ttermbox.c"
	@cd sub/termbox_next/ && (make >/dev/null)

$(NAME): $(OBJ) $(TRMBOX)
	@echo "\tLD\t\t$(NAME)"
	@$(CC) -o $(NAME) $(OBJ) $(TRMBOX) $(CFLAGS) $(LDFLAGS)

install: $(NAME)
	@echo "\tINSTALL\t\t$(NAME)\t$(DESTDIR)/$(PREFIX)/bin/$(NAME)"
	@install -m755 ./$(NAME) $(DESTDIR)/$(PREFIX)/bin/$(NAME)

uninstall:
	@echo "\tRM\t\t$(DESTDIR)/$(PREFIX)/bin/$(NAME)"
	@rm -f $(DESTDIR)/$(PREFIX)/bin/$(NAME)
.PHONY: all clean install
