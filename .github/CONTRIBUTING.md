<!-- omit in toc -->

# Contributing to the Notebookinator

First off, thanks for taking the time to contribute! ❤️

All types of contributions are encouraged and valued. See the [Table of Contents](#table-of-contents) for different ways to help and details about how this project handles them. Please make sure to read the relevant section before making your contribution. It will make it a lot easier for us maintainers and smooth out the experience for all involved. The community looks forward to your contributions. 🎉

> And if you like the project, but just don't have time to contribute, that's fine. There are other easy ways to support the project and show your appreciation, which we would also be very happy about:
>
> - Star the project
> - Refer this project in your project's readme
> - Mention the project to other competitors

<!-- omit in toc -->

## Table of Contents

- [I Have a Question](#i-have-a-question)
- [I Want To Contribute](#i-want-to-contribute)
- [Reporting Bugs](#reporting-bugs)
- [Suggesting Enhancements](#suggesting-enhancements)
- [Your First Code Contribution](#your-first-code-contribution)
- [Improving The Documentation](#improving-the-documentation)
- [Style Guides](#style-guides)
- [Typst Code](#typst-code)
- [Commit Messages](#commit-messages)

## I Have a Question

> If you want to ask a question, we assume that you have read the available [Documentation](../docs.pdf).

Before you ask a question, it is best to search for existing [Issues](https://github.com/BattleCh1cken/notebookinator.git/issues) that might help you. In case you have found a suitable issue and still need clarification, you can write your question in this issue. It is also advisable to search the internet for answers first.

If you then still feel the need to ask a question and need clarification, we recommend the following:

- Open an [Issue](https://github.com/BattleCh1cken/notebookinator.git/issues/new).
- Provide as much context as you can about what you're running into.
- Provide project and platform versions (typst, other packages, etc), depending on what seems relevant.

We will then take care of the issue as soon as possible.

<!--
You might want to create a separate issue tag for questions and include it in this description. People should then tag their issues accordingly.

Depending on how large the project is, you may want to outsource the questioning, e.g. to Stack Overflow or Gitter. You may add additional contact and information possibilities:
- IRC
- Slack
- Gitter
- Stack Overflow tag
- Blog
- FAQ
- Roadmap
- E-Mail List
- Forum
-->

## I Want To Contribute

> ### Legal Notice <!-- omit in toc -->
>
> When contributing to this project, you must agree that you have authored 100% of the content, that you have the necessary rights to the content and that the content you contribute may be provided under the project licence.

### Reporting Bugs

<!-- omit in toc -->

#### Before Submitting a Bug Report

A good bug report shouldn't leave others needing to chase you up for more information. Therefore, we ask you to investigate carefully, collect information and describe the issue in detail in your report. Please complete the following steps in advance to help us fix any potential bug as fast as possible.

- Make sure that you are using the latest version.
- Determine if your bug is really a bug and not an error on your side e.g. using incompatible environment components/versions (Make sure that you have read the [documentation](../docs.pdf). If you are looking for support, you might want to check [this section](#i-have-a-question)).
- To see if other users have experienced (and potentially already solved) the same issue you are having, check if there is not already a bug report existing for your bug or error in the [bug tracker](https://github.com/BattleCh1cken/notebookinator.git/issues?q=label%3Abug).
- Also make sure to search the internet (including Stack Overflow) to see if users outside of the GitHub community have discussed the issue.
- Collect information about the bug:
- Stack trace (Traceback)
- OS, Platform and Version (Windows, Linux, MacOS, x86, ARM)
- Typst version
- Notebookinator version
- Versions of any other relevant libraries
- Relevant code snippets
- Can you reliably reproduce the issue? And can you also reproduce it with older versions?

<!-- omit in toc -->

#### How Do I Submit a Good Bug Report?

> You must never report security related issues, vulnerabilities or bugs including sensitive information to the issue tracker, or elsewhere in public. Instead sensitive bugs must be sent by email to <battlech1cken@larkov.de>.

We use GitHub issues to track bugs and errors. If you run into an issue with the project:

- Open an [Issue](https://github.com/BattleCh1cken/notebookinator.git/issues/new). (Since we can't be sure at this point whether it is a bug or not, we ask you not to talk about a bug yet and not to label the issue.)
- Explain the behaviour you would expect and the actual behaviour.
- Please provide as much context as possible and describe the _reproduction steps_ that someone else can follow to recreate the issue on their own. This usually includes your code. For good bug reports you should isolate the problem and create a reduced test case.
- Provide the information you collected in the previous section.

Once it's filed:

- The project team will label the issue accordingly.
- A team member will try to reproduce the issue with your provided steps. If there are no reproduction steps or no obvious way to reproduce the issue, the team will ask you for those steps and mark the issue as `needs reproduction`. Bugs with the `needs reproduction` tag will not be addressed until they are reproduced.
- If the team is able to reproduce the issue, it will be marked `bug`, as well as possibly other tags (such as `critical`), and the issue will be left to be [implemented by someone](#your-first-code-contribution).

<!-- You might want to create an issue template for bugs and errors that can be used as a guide and that defines the structure of the information to be included. If you do so, reference it here in the description. -->

### Suggesting Enhancements

This section guides you through submitting an enhancement suggestion for the Notebookinator, **including completely new features and minor improvements to existing functionality**. Following these guidelines will help maintainers and the community to understand your suggestion and find related suggestions.

<!-- omit in toc -->

#### Before Submitting an Enhancement

- Make sure that you are using the latest version.
- Read the [documentation](../docs.pdf) carefully and find out if the functionality is already covered, maybe by an individual configuration.
- Perform a [search](https://github.com/BattleCh1cken/notebookinator.git/issues) to see if the enhancement has already been suggested. If it has, add a comment to the existing issue instead of opening a new one.
- Find out whether your idea fits with the scope and aims of the project. It's up to you to make a strong case to convince the project's developers of the merits of this feature. Keep in mind that we want features that will be useful to the majority of our users and not just a small subset. If you're just targeting a minority of users, consider writing an add-on/plugin library.

<!-- omit in toc -->

#### How Do I Submit a Good Enhancement Suggestion?

Enhancement suggestions are tracked as [GitHub issues](https://github.com/BattleCh1cken/notebookinator.git/issues).

- Use a **clear and descriptive title** for the issue to identify the suggestion.
- Provide a **step-by-step description of the suggested enhancement** in as many details as possible.
- **Describe the current behaviour** and **explain which behaviour you expected to see instead** and why. At this point you can also tell which alternatives do not work for you.
- You may want to **include screenshots and animated GIFs** which help you demonstrate the steps or point out the part which the suggestion is related to. You can use [this tool](https://www.cockos.com/licecap/) to record GIFs on MacOS and Windows, and [this tool](https://github.com/colinkeenan/silentcast) or [this tool](https://github.com/GNOME/byzanz) on Linux.
- **Explain why this enhancement would be useful** to most of the Notebookinator's users. You may also want to point out the other projects that solved it better and which could serve as inspiration.

<!-- You might want to create an issue template for enhancement suggestions that can be used as a guide and that defines the structure of the information to be included. If you do so, reference it here in the description. -->

### Your First Code Contribution

> Using a development environment different from the one recommended below is fine, but you will have to adjust the steps yourself.

We recommend using [Visual Studio Code](https://code.visualstudio.com/) as your IDE. It is free, open-source, and cross-platform.

We also recommend the following extensions:

- [Typst LSP](https://marketplace.visualstudio.com/items?itemName=nvarner.typst-lsp)
- [Typst Preview](https://marketplace.visualstudio.com/items?itemName=mgt19937.typst-preview)
- [Code Spell Checker](https://marketplace.visualstudio.com/items?itemName=streetsidesoftware.code-spell-checker) to check for spelling mistakes

Of course, you'll also need to install [Typst](https://github.com/typst/typst#installation).

In order to contribute to the Notebookinator, you will need to [fork](https://help.github.com/en/github/getting-started-with-github/fork-a-repo) the repository and clone it to your local machine.

Once you've cloned your repository, you can make your changes. When you're ready to test your changes, create a file called `test.typ` in the root of the project, and import `lib.typ`. View the output with Typst Preview, or render it yourself with `typst compile test.typ`

You can then [commit](#commit-messages) your changes to your fork. Once you are done, you can [create a pull request](https://help.github.com/en/github/collaborating-with-issues-and-pull-requests/creating-a-pull-request) to the master branch. You can use the [Pull Request Template](PULL_REQUEST_TEMPLATE.md) to structure your pull request.

### Improving The Documentation

We use [Tidy](https://github.com/Mc-Zen/tidy/tree/main) to generate our documentation. This means that most of our documentation is written directly in the code as comments.

You can improve the documentation in the following places:

- The comments directly in the code
- The documentation in [`docs.typ`](../docs.typ)
- The template for the docs at [`docs-template.typ`](../docs-template.typ)
- The [README](../README.md)
- The [contributing guide](./CONTRIBUTING.md)(this file)

Once you've made your changes, submit your changes as a pull request, as described above.

## Style Guides

### Typst Code

Currently we do not have an established coding style. In the future we'll use the [Typstfmt](https://github.com/astrale-sharp/typstfmt) formatter to enforce our style, but it is not robust enough to meet our needs as of now.

### Commit Messages

Commit messages should be short and descriptive. This project follows the [Gitmoji](https://gitmoji.dev/about) commit style.

Use the unicode version of the emojis wherever possible. This means you should write 🔥 instead of :fire:.

## Attribution

This guide is based on the **contributing-gen**. [Make your own](https://github.com/bttger/contributing-gen)!
