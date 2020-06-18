# Ansible Collection: community.windows

[![Run Status](https://api.shippable.com/projects/5e6068ebe4b17a000756145d/badge?branch=master)](https://app.shippable.com/github/ansible-collections/community.windows/dashboard/jobs)
[![codecov](https://codecov.io/gh/ansible-collections/community.windows/branch/master/graph/badge.svg)](https://codecov.io/gh/ansible-collections/community.windows)

This repo hosts the `community.windows` Ansible Collection.

The collection includes the community plugins to help the management of Windows hosts.


## Included content

<!--start collection content-->
<!--end collection content-->


## Installation and Usage

### Installing the Collection from Ansible Galaxy

Before using the Windows collection, you need to install it with the `ansible-galaxy` CLI:

    ansible-galaxy collection install community.windows

You can also include it in a `requirements.yml` file and install it via `ansible-galaxy collection install -r requirements.yml` using the format:

```yaml
collections:
- name: community.windows
```


## Testing and Development

If you want to develop new content for this collection or improve what's already here, the easiest way to work on the collection is to clone it into one of the configured [`COLLECTIONS_PATHS`](https://docs.ansible.com/ansible/latest/reference_appendices/config.html#collections-paths), and work on it there.


### Generating plugin docs

Currently module documentation is generated manually using
[add_docs.py](https://github.com/ansible-network/collection_prep/blob/master/add_docs.py). This should be run whenever
there are any major doc changes or additional plugins have been added to ensure a docpage is viewable online in this
repo. The following commands will run the doc generator and create the updated doc pages under [docs](docs).

```bash
# This is the path to the ansible.windows checkout
COLLECTION_PATH=~/ansible_collections/community/windows

cd /tmp
git clone https://github.com/ansible-network/collection_prep.git
cd collection_prep
python add_docs.py -p "${COLLECTION_PATH}"
```


### Testing with `ansible-test`

The `tests` directory contains configuration for running sanity and integration tests using [`ansible-test`](https://docs.ansible.com/ansible/latest/dev_guide/testing_integration.html).

You can run the collection's test suites with the commands:

    ansible-test sanity --docker
    ansible-test windows-integration --docker


## Publishing New Version

The current process for publishing new versions of the Windows Community Collection is manual, and requires a user who has access to the `community` namespace on Ansible Galaxy to publish the build artifact.

* Update the CHANGELOG:
  * Make sure you have [`antsibull-changelog`](https://pypi.org/project/antsibull-changelog/) installed.
  * Make sure there are fragments for all known changes in `changelogs/fragments`.
  * Run `antsibull-changelog release`
* Update `galaxy.yml` with the new `version` for the collection.
* Create a release in GitHub to tag the commit at the version to build.
* Run the following commands to build and release the new version on Galaxy:
  ```
  ansible-galaxy collection build
  ansible-galaxy collection publish ./community-windows-$VERSION_HERE.tar.gz
  ```

After the version is published, verify it exists on the [Windows Community Collection Galaxy page](https://galaxy.ansible.com/community/windows).


## More Information

For more information about Ansible's Windows integration, join the `#ansible-windows` channel on Freenode IRC, and browse the resources in the [Windows Working Group](https://github.com/ansible/community/wiki/Windows) Community wiki page.


## License

GNU General Public License v3.0 or later

See [COPYING](COPYING) to see the full text.
