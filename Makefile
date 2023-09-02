SRC=src
INCLUDE=include
TEST=test
OUT=out

PACKAGES:=list
SOURCES:=$(foreach package,$(PACKAGES),$(wildcard $(SRC)/$(package)/*.c))
SOURCES+=$(SRC)/util.c
TESTS:=$(foreach package, $(PACKAGES), $(wildcard $(TEST)/$(package)/*.c))

CC=/usr/bin/gcc
CFLAGS=-g -Iinclude -Wall
TARGET:=algo
TARGET_NAME:=$(addprefix $(OUT)/bin/lib,$(addsuffix .so,$(TARGET)))

BASH:=/usr/bin/bash

define mkdir_guard =
mkdir -p $(dir $(1))
endef

show:
	@echo PACKAGES:			$(PACKAGES)
	@echo SOURCES:			$(SOURCES)
	@echo TESTS:			$(TESTS)
	@echo OBJS:				$(OBJS)
	@echo TARGET_NAME:		$(TARGET_NAME)
	@echo TEST_EXECUTABLES: $(TEST_EXECUTABLES)


############################################################
# BUILD .so
############################################################

# Build objs here.

define to_output =
$(addprefix $(OUT)/bin/,$(patsubst %.c,%.o,$(1)))
endef
define C_BUILD_template = 
$$(call to_output,$(1)): $(1)
	@$$(call mkdir_guard, $$@)
	@mkdir -p $$(dir $$@)
	$(CC) $(CFLAGS) -c -fpic -o $$@ $$^
endef
$(foreach source,$(SOURCES),$(eval $(call C_BUILD_template, $(source))))
OBJS = $(foreach src,$(SOURCES),$(call to_output,$(src)))

# Build .so library with objs.
$(TARGET_NAME): $(OBJS)
	$(CC) $(CFLAGS) --shared -o $@ $^

build: $(TARGET_NAME)

############################################################
# TESTS            
############################################################

define TO_TEST_EXECUTABLE = 
$(OUT)/test/$(notdir $(basename $(1)))
endef

TEST_EXECUTABLES = $(foreach test,$(TESTS),$(call TO_TEST_EXECUTABLE,$(test)))

define BUILD_TEST_EXECUTABLE_template = 
$$(call TO_TEST_EXECUTABLE,$(1)): $(1) $(TARGET_NAME)
	$$(call mkdir_guard, $$@)
	$(CC) $(CFLAGS) -L $(dir $(TARGET_NAME)) -l$(TARGET) -o $$@ $$^
endef

$(foreach test,$(TESTS),$(eval $(call BUILD_TEST_EXECUTABLE_template,$(test))))

test: $(TEST_EXECUTABLES)
	$(BASH) scripts/test.sh	


clean:
	rm -rf $(OUT)

.PHONY: test clean all