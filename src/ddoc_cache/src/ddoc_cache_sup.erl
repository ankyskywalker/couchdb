% Licensed under the Apache License, Version 2.0 (the "License"); you may not
% use this file except in compliance with the License. You may obtain a copy of
% the License at
%
%   http://www.apache.org/licenses/LICENSE-2.0
%
% Unless required by applicable law or agreed to in writing, software
% distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
% WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
% License for the specific language governing permissions and limitations under
% the License.

-module(ddoc_cache_sup).
-behaviour(supervisor).


-export([
    start_link/0,
    init/1
]).


start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).


init([]) ->
    Children = [
        {
            ddoc_cache_tables,
            {ddoc_cache_tables, start_link, []},
            permanent,
            5000,
            worker,
            [ddoc_cache_tables]
        },
        {
            ddoc_cache_lru,
            {ddoc_cache_lru, start_link, []},
            permanent,
            5000,
            worker,
            [ddoc_cache_lru]
        },
        {
            ddoc_cache_opener,
            {ddoc_cache_opener, start_link, []},
            permanent,
            5000,
            worker,
            [ddoc_cache_opener]
        }
    ],
    {ok, {{one_for_all, 25, 1}, Children}}.
