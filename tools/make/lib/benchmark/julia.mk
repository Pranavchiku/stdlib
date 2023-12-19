#/
# @license Apache-2.0
#
# Copyright (c) 2017 The Stdlib Authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#/

# RULES #

#/
# Runs Julia benchmarks consecutively.
#
# ## Notes
#
# -   The recipe assumes that benchmark files can be run via Julia.
# -   This rule is useful when wanting to glob for Julia benchmark files (e.g., run all Julia benchmarks for a particular package).
#
#
# @param {string} [BENCHMARKS_FILTER] - file path pattern (e.g., `.*/math/base/special/erf/.*`)
#
# @example
# make benchmark-julia
#
# @example
# make benchmark-julia BENCHMARKS_FILTER=".*/math/base/special/erf/.*"
#/
benchmark-julia:
	$(QUIET) $(FIND_JULIA_BENCHMARKS_CMD) | grep '^[\/]\|^[a-zA-Z]:[/\]' | while read -r file; do \
		echo ""; \
		echo "Running benchmark: $$file"; \
		$(MAKE_EXECUTABLE) $$file && $$file || exit 1; \
	done

.PHONY: benchmark-julia

#/
# Runs a specified list of Julia benchmarks consecutively.
#
# ## Notes
#
# -   The recipe assumes that benchmark files can be run via Julia.
# -   This rule is useful when wanting to run a list of Julia benchmark files generated by some other command (e.g., a list of changed Julia benchmark files obtained via `git diff`).
#
#
# @param {string} FILES - list of Julia benchmark file paths
#
# @example
# make benchmark-julia-files FILES='/foo/benchmark.jl /bar/benchmark.jl'
#/
benchmark-julia-files:
	$(QUIET) for file in $(FILES); do \
		echo ""; \
		echo "Running benchmark: $$file"; \
		$(MAKE_EXECUTABLE) $$file && $$file || exit 1; \
	done

.PHONY: benchmark-julia-files