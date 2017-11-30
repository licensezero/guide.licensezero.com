<img src="https://licensezero.com/logo.svg" class="logo">

# License Zero Developer's Guide

License Zero is a game plan for financially sustaining your independent work on open software.  License Zero lets you make two new kinds of deals with users of the software you make online:

> Use my software freely for open source or noncommercial work, but otherwise buy a license online, to support me.

It's the model of GitHub, Travis CI, and other leading developer services, adapted for library, framework, and tools developers.  Finally.

This is a guide to License Zero, the project's primary documentation for developers looking to sustain their work with that system.  If you're interested in using License Zero to license your work, you should read this guide.

## Contents

1.  [Overview](#overview)
2.  [Public Licenses](#public-licenses)
3.  [Private Licenses](#private-licenses)
4.  [Waivers](#waivers)
5.  [Relicensing](#relicensing)
6.  [licensezero.com](#licensezero.com)
7.  [Contributions](#contributions)
8.  [Complimentary Approaches](#complimentary-approaches)

## <a id="overview">Overview</a>

```python
def system(user, project):
  # See "Public Licenses" below.
  if user.meets_conditions_of(project.public_license):
    project.public_license.permit(user)
  else:
    # See "Private Licenses" below.
    private_license = user.private_license_for(project)
    if private_license && user.meets_conditions_of(private_license):
      private_license.permit(user)
    # See "Waivers" below.
    else:
      waiver = user.waiver_for(project)
      if waiver:
        waiver.permit(user)
      # See "licensezero.com" below.
      else:
        license_zero.buy_private_license(user, project)
```

As an independent software developer, you control who can use your software, and under what terms.  License Zero licenses give everyone broad permission to use and build with your software, as long as they limit commercial use or share work they build on yours back as open source, depending on the license terms you choose.  Users who can't meet those conditions need different license terms to use your software.

[licensezero.com](https://licensezero.com) sells those users separate, private licenses for commercial and proprietary use, on your behalf.  [Stripe](https://stripe.com) processes payments directly to an account in your name.  A [command line interface](https://www.npmjs.com/packages/licensezero) makes it easy for users to buy all the private licenses they need for a Node.js project at once, with a single credit card transaction.  The same tool makes it easy for you to sign up, start offering new projects, and set pricing.

## <a id="public-licenses">Public Licenses</a>

License Zero starts where you exercise your power as the owner of intellectual property in your work: in your project's `LICENSE` file.  You might currently use [The MIT License](https://spdx.org/licenses/MIT), [a BSD license](https://spdx.org/licenses/BSD-2-Clause), or a similar open source license in that file now, to give the community permission to use your work.  License Zero offers you two alternatives:

1.  [The License Zero Noncommercial Public License (L0&#x2011;NC)](https://licensezero.com/licenses/noncommercial) gives everyone broad permission to use your software, but limits commercial use to a short trial period of seven days.  When a commercial user's trial runs out, they need to buy a different license or stop using your software.  In that way, L0&#x2011;NC works a bit like a [Creative Commons NonCommercial license](https://creativecommons.org/licenses/by-nc/4.0/), but for software.

2.  [The License Zero Reciprocal Public License (L0&#x2011;R)](https://licensezero.com/licenses/reciprocal) requires users who change, build on, or use your work to create software to release their work as open source, too.  If users can't or won't share their work as open source, they need to buy a different license that allows proprietary use of the software.  In that way, L0&#x2011;R works a bit like a _copyleft_ license such as [AGPL](https://www.gnu.org/licenses/agpl-3.0.html), but requires users to release more of their own code, in more situations.

Both L0 public licenses are short and readable.  You should [read](https://licensezero.com/licenses/noncommercial) [them](https://licensezero.com/licenses/reciprocal).

### <a id="comparing-public-licenses">Comparing the Public Licenses</a>

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

    - If the library is licensed under L0&#x2011;NC, the company can only use the library for seven days under its public license.  Then they need to buy a private license.

    - If the library is licensed under L0&#x2011;R, the company needs to buy a private license to use it in their web app at all.  They can't use the library under its public license, because they won't meet its conditions by releasing their web app as open source.

2.  A for-profit company wants to use a License Zero library in the data synchronization software they ship with voice recorders they make.  They plan to release the sync software as open source.

    - If the library is licensed under L0&#x2011;NC, the company can only use the library for seven days under the public license.  Then they need to buy a private license.  Moreover, any company customer can only use the library for commercial commercial purposes under the public license for seven days.  Then they need to buy a private license, too.

    - If the library is licensed under L0&#x2011;R, the company can use the library in their sync software under the public license, as long as they actually release the sync software as open source.  The company's customers can use the sync software, with the library, for any purpose, as long as they share any new work of their own using the library as open source.

3.  A for-profit company wants to use a License Zero video player application to show commercials in their office lobby.

    - If the application is licensed under L0&#x2011;NC, the company can only use the application for seven days under the public license.  Then they need to buy a private license.

    - If the application is licensed under L0&#x2011;R, the company is free to use the application for as long as they like under the public license.

L0&#x2011;NC allows users to build and use closed and proprietary software with your work, as long they use it for noncommercial purposes.  L0&#x2011;R allows users to build and use only open source software with your work, even for very profit-driven purposes.  Many noncommercial software users are happy to make their work open source, but many make closed software, too.  Many for-profit companies make proprietary software, but many also make and release open source software, too.

License Zero was inspired by imbalances in the relationship between open source developers and users.  Both License Zero public licenses represent new deals between developers and users, designed to redress that imbalance.  It isn't clear yet which public license approach is "best", overall, for any particular kind of software, or in any particular kind of situation.

### <a id="open-source-and-free-software">Open Source and Free Software</a>

The public licenses also differ in some meaningful political ways you should be aware of.

L0&#x2011;NC is not an "open source" or "free software" license as many community members define those terms, because it discriminates against business use.  Source for L0&#x2011;NC can still be published and developed online, using many popular services like GitHub and npm.  But many in those communities will not accept it as part of their movements.

L0&#x2011;R, on the other hand, was written to conform to the [Open Source Definition](https://opensource.org/osd), and proposed to the Open Source Initiative for approval.  Approval has been controversial, in part because L0&#x2011;R goes further than existing licenses in when and what code it requires be released as open source.

L0&#x2011;R is probably not a "free software" license [as defined by the Free Software Foundation](https://www.gnu.org/philosophy/free-sw.html).  FSF's definition of free software requires granting freedoms to run, copy, distribute, study, change and improve software.  But it also recognizes that some conditions on those freedoms can enhance software freedom overall by ensuring that others also receive source code and freedom to work with it.  However, FSF's definition of free software admits only conditions on the freedom to share modified versions with others.  That partially explains why the Open Source Initiative [approved RPL&#x2011;1.5](https://opensource.org/licenses/RPL-1.5), a thematic predecessor of L0&#x2011;R, as open source while FSF [considers RPL non-free](https://www.gnu.org/licenses/license-list.en.html#RPL).

## <a id="private-licenses">Private Licenses</a>

Users who can't meet the terms of the License Zero public license you choose for your project can buy a private license that allows them, and only them, to use your work.

License Zero publishes a [standard form private license](https://licensezero.com/licenses/private).  The private license is based on [The Apache License, Version 2.0](https://apache.org/licenses/LICENSE-2.0), with changes that transform it from a permissive open source license into a proprietary license.  It comes in four variants:

1.  a "solo tier" private license for a single person
2.  a "team tier" private license for up to 10 people
2.  a "company tier" private license for up to 100 people
3.  an "enterprise tier" private license for an unlimited number of people

Each private license grants the buyer broad permission under copyright and patent law to use the software.  Team-, company-, and enterprise-tier private licenses also allow the buyer to extend, or sublicense, that permission to employees and independent contractors.  (Independent contractors must be individuals, not companies.)  Team- and company-tier private licenses limit the number of people the buyer can sublicense in any rolling one-year period.

Note that the private license terms do _not_ allow buyers to sublicense their customers, or others who want to use software they build on top of your project.  Those users will need to abide by the terms of your public license, or purchase private licenses for themselves.  [Relicensing](#relicensing), covered below, allows you to offer to make your project broadly usable on that kind of basis for a price.

## <a id="waivers">Waivers</a>

## <a id="relicensing">Relicensing</a>

License Zero allows, but does not require, setting a price at which you agree to change the public license terms of your contributions to a project to those of [The License Zero Permissive Public License (L0&#x2011;P)](https://licensezero.com/licenses/permissive).  This is called "relicensing".

### <a id="permissive-license">Permissive License</a>

L0&#x2011;P is a highly permissive open source software license, much like [The MIT License](https://spdx.org/licenses/MIT) and [the two-clause BSD license](https://spdx.org/licenses/BSD-2-Clause), but easier to read and more legally complete.  It gives everyone who receives a copy of your software permission under copyright and patent law to work with and built on it in any way they like, as long as they preserve your license information in copies they give to others and refrain from suing users of your project for violating patents on it.

Relicensing your project under L0&#x2011;P removes any reason for users to purchase private licenses for your project.  Under the [agency terms](https://licensezero.com/terms/agency) you must agree to in order to offer private licenses for a project through License Zero, you must retract your project for sale through the API if you relicense it.

You're free to use L0&#x2011;P for projects that you don't license through License Zero, as well.

### <a id="relicense-agreement">Relicense Agreement</a>

The [relicense agreement](https://licensezero.com/licenses/relicense) sets out the terms of agreement between you and the sponsor who pays your set price.  When a customer pays the price you set to relicense your project, Artless Devices LLC, the company behind License Zero, signs the relicense agreement on your behalf.  (You give Artless Devices permission to do this, as your legal "agent", under the [agency terms](https://licensezero.com/terms/agency) you must agree to in order to set a relicense price.)

As the developer, your obligations are set out in the "Relicensing" section of the agreement.

## <a id="licensezero.com">licensezero.com</a>

<img src="vending-machine.svg" class="vending-machine">

## <a id="contributions">Contributions</a>

## <a id="complimentary-approaches">Complimentary Approaches</a>

License Zero isn't the only way to financially support your work on open software, and it tries its best to remain compatible with other opportunities.

### <a id="donations">Donations</a>

Ask people and companies for money, and hope they give it to you.

### <a id="merchandise">Merchandise</a>

Sell books, stickers, shirts, and other physical goods with your project's name or logo.

### <a id="advertising">Advertising</a>

Sell or exchange the right to put company advertising, branding, or support acknowledgments in your project's documentation, on your project's website or social media accounts, or even in your software itself.

### <a id="delayed-release">Delayed Release</a>

Give paying customers early access to your work ahead of its release as open source, some time later.

### <a id="trademark-licensing">Trademark Licensing</a>

Require others to support you financially in order to use a trademark to identify themselves as providers of related products or services.  Trademark licensing for service providers is often coupled with [advertising](#advertising), in the form of a listing among service providers on the project's website.

### <a id="training">Training</a>

Charge companies, conferences, or other venues to train others in the use of your project, in person or remotely.

### <a id="support">Support</a>

Charge for access to and use of your time to assist users in using your work.

### <a id="grants">Grants</a>

Apply to grant-making institutions and government entities for financial support in support your work, if it aligns with their objectives.

### <a id="hosting">Hosting</a>

Charge others to install, configure, and run your project on their behalf.

### <a id="integration">Integration</a>

Charge others to integrate your work into their applications or services.

### <a id="paid-development">Paid Development</a>

Charge others for work they would like to do, such as bug fixes, feature adds, and other changes.

### <a id="proprietary-software">Proprietary Software</a>

Sell proprietary software relating to or enhancing your open project.  For example, many open source database companies license proprietary optimizations, monitoring tools, and replication features.
