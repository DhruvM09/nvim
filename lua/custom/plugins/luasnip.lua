return {

  'L3MON4D3/LuaSnip',
  -- follow latest release.
  version = 'v2.*', -- Replace <CurrentMajor> by the latest released major (first number of latest release)
  -- install jsregexp (optional!).
  dependencies = {
    'rafamadriz/friendly-snippets',
  },
  build = 'make install_jsregexp',
  config = function()
    require('luasnip.loaders.from_vscode').lazy_load()
    local ls = require 'luasnip'
    local s = ls.snippet
    local t = ls.text_node
    local i = ls.insert_node

    ls.add_snippets('cpp', {
      s('!cp', {
        t {
          '#include <bits/stdc++.h>',
          'using namespace std;',
          '#define vi vector<int>',
          '#define vvi vector<vector<int>>',
          '#define ll long long int',
          '#define loop(i,start,stop,inc) for(int i = start;i<stop;i+=inc)',
          '#define readVec(x) for(int i = 0 ; i < x.size();i++)cin >> x[i];',
          '#define debug(x) cerr << #x << ": " << (x) << "\n";',
          "#define debugvec(x) for(int i = 0 ; i  <x.size();i++)cerr<< x[i] << ' ';",
          '#define pb push_back',
          '#define ppb pop_back',
          '#define all(x) (x).begin(), (x).end()',
          'const int MOD = 1e9 + 7;',
          'll expo(ll a, ll b, ll mod) {ll res = 1; while (b > 0) {if (b & 1)res = (res * a) % mod; a = (a * a) % mod; b = b >> 1;} return res;}',
          'll mminvprime(ll a, ll b) {return expo(a, b - 2, b);}',
          'll mod_add(ll a, ll b) { return (a + b) % MOD; }',
          'll mod_sub(ll a, ll b) { return (a - b + MOD) % MOD; }',
          'll mod_mul(ll a, ll b) { return (a * b) % MOD; }',
          'll gcd(ll a, ll b) {if (b > a) {return gcd(b, a);} if (b == 0) {return a;} return gcd(b, a % b);}',
          'vector<ll> sieve(int n) {int*arr = new int[n + 1](); vector<ll> vect; for (int i = 2; i <= n; i++)if (arr[i] == 0) {vect.push_back(i); for (int j = 2 * i; j <= n; j += i)arr[j] = 1;} return vect;}',
          'int binary_search(vector<int>& arr, int target) {int low = 0, high = arr.size() - 1;while (low <= high) {int mid = low + (high - low) / 2;if (arr[mid] == target) return mid; if (arr[mid] < target) low = mid + 1;else high = mid - 1; } return -1;}',
          '/*-------------------------------------------------------------Dhruv_M-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/',
          'void solve(){',
        },
        i(0),
        t {
          '}',
          'int main(){',
          'ios_base::sync_with_stdio(0);',
          'cin.tie(0);cout.tie(0);',
          'int testcase = 1;',
          '//cin>>testcase;',
          'while(testcase--){',
          'solve();',
          '}',
          'return 0;',
          '}',
        },
      }),
    })
  end,
}
