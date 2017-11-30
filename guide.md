# License Zero Developer's Guide

License Zero is a game plan for financially sustaining your independent work on open software.  License Zero lets you make new kinds of deals with users of the software you make online:  Use my software freely for open source or noncommercial work, but otherwise buy a license online, to support me.  It's the model of GitHub, Travis CI, and other leading developer services, adapted for library, framework, and tools developers.  Finally.

This is a guide to License Zero, the project's primary documentation for developers looking to sustain their work with that system.  If you're interested in using License Zero to license your work, you should read this guide.

## In Brief

```python
def system(user, project):
  if user.meets_conditions_of(project.public_license):
    project.public_license.permit(user)
  else:
    private_license = user.private_license_for(project)
    if private_license && user.meets_conditions_of(private_license):
      private_license.permit(user)
    else:
      license_zero.buy_private_license(user, project)
```

As an independent software developer, you control who can use your software, and under what terms.  License Zero licenses give everyone broad permission to use and build with your software, as long as they limit commercial use or share work they build on yours back as open source, depending on the license terms you choose.  Users who can't meet those conditions need different license terms to use your software.

[licensezero.com](https://licensezero.com) sells those users separate, private licenses for commercial and proprietary use, on your behalf.  [Stripe](https://stripe.com) processes payments directly to an account in your name.  A [command line interface](https://www.npmjs.com/packages/licensezero) makes it easy for users to buy all the private licenses they need for a Node.js project at once, with a single credit card transaction.  The same tool makes it easy for you to sign up, start offering new projects, and set pricing.

## Public Licenses

As an independent software developer, writing software on your own time and dime, without assigning intellectual property to anyone else, you have awesome legal power to decide how others can use your work.  License Zero starts where you exercise this power, in `LICENSE`.  You might use [The MIT License](https://spdx.org/licenses/MIT), [a BSD license](https://spdx.org/licenses/BSD-2-Clause), or a similar open source license to give the community the right to use your work today.  License Zero offers you a choice of two alternatives:

1.  [The License Zero Noncommercial Public License (L0-NC)](https://licensezero.com/licenses/noncommercial) gives everyone broad permission to use your software, but limits commercial use to a short trial period of seven days.  When a commercial user's trial runs out, they need to buy a different license or stop using your software.  In that way, L0-NC works a bit like a [Creative Commons NonCommercial license](https://creativecommons.org/licenses/by-nc/4.0/), but for software.

2.  [The License Zero Reciprocal Public License (L0-R)](https://licensezero.com/licenses/reciprocal) requires users who change, build on, or use your work to create software to release their work as open source, too.  If users can't or won't share their work as open source, they need to buy a different license that allows proprietary use of the software.  In that way, L0-R works a bit like a _copyleft_ license such as [AGPL](https://www.gnu.org/licenses/agpl-3.0.html), but requires users to release more of their own code, in more situations.

Both L0 public licenses are short and readable.  You should [read](https://licensezero.com/licenses/noncommercial) [them](https://licensezero.com/licenses/reciprocal).

### Comparing the Public Licenses

The two License Zero public licenses aren't just worded differently.  They achieve different results.  Abstracting them a bit:

```python
def noncommercial_license:
  if commercial_user:
    if within_trial_period:
      return 'free to use'
    else:
      return 'need to buy a different license'
  else:
    return 'free to use'

def reciprocal_license:
  if building_software:
    if release_software_as_open_source:
      return 'free to use'
    else:
      return 'need to buy a different license'
  else:
    return 'free to use'
```

Consider a few user scenarios, and how they play out under different License Zero public licenses:

1.  A for-profit company wants to use a License Zero library in their proprietary web app.

    - If the library is licensed under L0-NC, the company can only use the library for a few days.  Then they have to buy a different license that permits commercial use beyond the trial period.

    - If the library is licensed under L0-R, the company needs to buy a private license for any use of the library.  Because they won't release their web app as open source, they can't meet L0-R conditions, and need to buy a private license for use without releasing as open source.

2.  A for-profit company wants to use a License Zero library in the data synchronization software they ship with their voice recorders.  They plan to release the sync software as open source.

    - If the library is licensed under L0-NC, the company can only use the library for a few days before they need to buy a private license.  Moreover, the company's customers will be limited to trial periods for free commercial use, too.

    - If the library is licensed under L0-R, the company can use the library in their sync software, as long as they actually release the sync software as open source.  The company's customers can use the sync software, with the library, for any purpose, as long as they share any new work of their own using the library as open source.

3.  A for-profit company wants to use a License Zero video player application to show commercials in their office lobby.

    - If the application is licensed under L0-NC, the company can only use the application for seven days.  Then they have to buy a different license that permits commercial use beyond the trial period.

    - If the application is licensed under L0-R, the company is free to use the application for as long as they like.

Many noncommercial software users are happy to make their work open source, but many do not.  Many for-profit companies make proprietary software, but many also make and release open source software.  L0-NC allows users to build and use closed software on top of your open work, as long it's used for noncommercial reasons.  L0-R allows users to build and use open source on top of your work, even for very profit-driven reasons.

### Open Source and Free Software

The public licenses also differ in some meaningful political ways you should be aware of.

L0-NC is not an "open source" or "free software" license as many community members define those terms, because it discriminates against business use.  Source for L0-NC can still be published and developed online, using many popular services like GitHub and npm.  But many in those communities will not accept it.

L0-R, on the other hand, was written to conform to the [Open Source Definition](https://opensource.org/osd), and License Zero proposed L0-R to the Open Source Initiative for approval.  Approval has been controversial, in part because L0-R goes further than existing licenses in when and what code it requires be released as open source.

L0-R is probably not a "free software" license [as defined by the Free Software Foundation](https://www.gnu.org/philosophy/free-sw.html).  FSF's definition of free software requires granting four freedoms, and anticipates that conditions on exercise of those freedoms can enhance software freedom overall, but admits only conditions on the freedom to share modified versions with others.  That partially explains why the Open Source Initiative [approved RPL-1.5](https://opensource.org/licenses/RPL-1.5), a thematic predecessor of L0-R, as open source while FSF [considers RPL non-free](https://www.gnu.org/licenses/license-list.en.html#RPL).

## Private Licenses

## Waivers

## Relicensing

## Outside Contributions

## Other Approaches

License Zero isn't the only way to financially support your work on open software, and it tries its best to remain compatible with other opportunities.

### Donations

Ask people and companies for money, and hope they give it to you.

### Merchandise

Sell books, stickers, shirts, and other physical goods with your project's name or logo.

### <a id="advertising">Advertising</a>

Sell or exchange the right to put company advertising, branding, or support acknowledgments in your project's documentation, on your project's website or social media accounts, or even in your software itself.

### Delayed Release

Give paying customers early access to your work ahead of its release as open source, some time later.

### Trademark Licensing

Require others to support you financially in order to use a trademark to identify themselves as providers of related products or services.  Trademark licensing for service providers is often coupled with [advertising](#advertising), in the form of a listing among service providers on the project's website.

### Training

Charge companies, conferences, or other venues to train others in the use of your project, in person or remotely.

### Support

Charge for access to and use of your time to assist users in using your work.

### Grant Funding

Apply to grant-making institutions and government entities for financial support in support your work, if it aligns with their objectives.

### Hosting

Charge others to install, configure, and run your project on their behalf.

### Integration

Charge others to integrate your work into their applications or services.

### Paid Development

Charge others for work they would like to do, such as bug fixes, feature adds, and other changes.

### Related Proprietary Software

Sell proprietary software relating to or enhancing your open project.  For example, many open source database companies license proprietary optimizations, monitoring tools, and replication features.
