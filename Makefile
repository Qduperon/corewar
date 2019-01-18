# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: qduperon <qduperon@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2018/03/06 14:30:26 by qduperon          #+#    #+#              #
#    Updated: 2019/01/18 18:33:20 by qduperon         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

################################## DIRECTORIES #################################

ASM_DIR = asm_dir/
COREWAR_DIR = corewar_dir/

SRCS = srcs/
INCS = includes/
OBJS = objs/

################################### PROGRAMS ###################################

ASM = asm
COREWAR = corewar

##################################### LIBFT ####################################

LIB = libft/
LIBFT = $(LIB)libft.a
LIBFLAGS = -L$(LIB) -lft

###################################### ASM #####################################

ASM_PATH = $(ASM_DIR)$(SRCS)
I_ASM_PATH = $(ASM_DIR)$(INCS)
O_ASM_PATH = $(ASM_DIR)$(OBJS)

#################################### COREWAR ###################################

COREWAR_PATH = $(COREWAR_DIR)$(SRCS)
I_COREWAR_PATH = $(COREWAR_DIR)$(INCS)
O_COREWAR_PATH = $(COREWAR_DIR)$(OBJS)
DEPS_PATH = deps/

GLFW = $(COREWAR_DIR)$(DEPS_PATH)glfw/src/libglfw3.a
LINKLIB += -L$(COREWAR_DIR)$(DEPS_PATH)glfw/src

GLEW = $(COREWAR_DIR)$(DEPS_PATH)glew/src/glew.c
LINKLIB += -L$(COREWAR_DIR)$(DEPS_PATH)glew/src

FLAGSLIB = -lglfw3 -framework AppKit -framework OpenGL
FLAGSLIB += -framework IOKit -framework CoreVideo

COREWAR_SRCS = add_sub.c\
			   aff.c\
			   and_or_xor.c\
			   argv.c\
			   check.c\
			   color.c\
			   end.c\
			   fork_lfork.c\
			   free.c\
			   get_champ.c\
			   get_val.c\
			   init.c\
			   ld_lld.c\
			   ldi_lldi.c\
			   lib.c\
			   live.c\
			   main.c\
			   number.c\
			   op.c\
			   play.c\
			   proc.c\
			   st.c\
			   sti.c\
			   usage.c\
			   use.c\
			   value.c\
			   zjmp.c\
			   drawing.c\
			   init_drawing.c\
			   shader.c\
			   tools_display.c\
			   norme.c


COREWAR_OBJS = $(addprefix $(addprefix $(COREWAR_DIR), $(OBJS)), $(COREWAR_SRCS:.c=.o))

################################### COMPILING ##################################

CC = gcc
CFLAGS = -Wall -Wextra -Werror

all: $(LIBFT) $(ASM) $(D_ASM) $(COREWAR)

libft: $(LIBFT)

$(LIBFT):
	make -C $(LIB) > /dev/null || TRUE

$(ASM):
	make -C $(ASM_DIR)
	mv $(ASM_DIR)$(ASM) .

$(O_ASM_PATH)%.o: $(ASM_PATH)%.c
	mkdir -p $(O_ASM_PATH)
	$(CC) $(CFLAGS) $(INC_FLAG) -o $@ -c $< -I $(I_ASM_PATH) -I $(LIB)$(INCS)

$(COREWAR): $(LIBFT) $(COREWAR_OBJS)
	$(CC) $(CFLAGS) $(FLAGSLIB) $(COREWAR_OBJS) $(GLEW) $(LINKLIB) -o $@ $(LIBFLAGS) $(GLFW)

$(O_COREWAR_PATH)%.o: $(COREWAR_PATH)%.c
	mkdir -p $(O_COREWAR_PATH)
	$(CC) $(CFLAGS) $(INC_FLAG) -o $@ -c $< -I $(I_COREWAR_PATH) -I $(COREWAR_DIR)$(DEPS_PATH)freetype/include -I $(LIB)$(INCS)

clean:
	make clean -C $(LIB)
	make clean -C $(ASM_DIR)
	rm -rf $(O_ASM_PATH)
	rm -rf $(O_D_ASM_PATH)
	rm -rf $(O_COREWAR_PATH)

fclean: clean
	make fclean -C $(LIB)
	make fclean -C $(ASM_DIR)
	rm -f $(ASM)
	rm -f $(D_ASM)
	rm -f $(COREWAR)

re: fclean all
