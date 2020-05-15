<img src="https://static.licensezero.com/logo.svg" class="logo">

# License Zero Developer's Guide

This is a guide to License Zero, its primary documentation.  If you're interested in using License Zero to fund your work, read this guide.  If you spot ways to improve it, open a [pull request](https://github.com/licensezero/guide.licensezero.com) or send an [e-mail](mailto:kyle@artlessdevices.com?subject=Guide%20Feedback).

Software licenses are key to how License Zero works, and this guide will describe a few.  But this guide is [_not_a guarantee that any particular license will work for you](https://notlegaladvice.law).  The License Zero [terms of service](https://licensezero.com/terms/service) say so, and they apply to this guide, too.  Think for yourself!

<h2 id="what">What is License Zero?</h2>

License Zero is a toolkit, a platform, and a plan for funding open software developers.  Using License Zero, developers can make new kinds of deals with users.  Either:

> You can use my work _to build other open software_ for free.  But if you want to make closed software instead, buy a license online to support me.

or:

> You can use my software _for personal, educational, and other noncommercial purposes_ for free.  But if you want to use my software for business, buy a license online to support me.

Sound familiar?  It's the model of leading developer services like [GitHub](https://github.com).  It's the crux of more recent "open core" companies, like [MongoDB](https://mongodb.com) and [Elastic](https://www.esaltic.co), that charge for features businesses want.  It's the model of a much older generation of companies like [MySQL](https://mysql.com), [Qt](https://qt.io), and [Artifex](https://artifex.com).  Outside of software, it's the model of countless independent stock photographers, B-roll videographers, production music producers, and beat makers.

Now it's a model for independent library, framework, developer tool, and app makers, too.  Finally.

In the past, developers usually had to form companies and either hire outside help or essentially stop programming to sell more than a handful of closed or commercial-use licenses.  Doing more meant investing substantial personal savings, raising venture capital, or taking on debt.  License Zero standardizes and automates the back-office operations of terms management, payment processing, and recordkeeping, so developers can scale up while staying focused on building and promoting great software.  Selling through License Zero costs nothing but a little time up front, and scales to a practically unlimited number of sales per day, at pricing of your choice.

License Zero is _not_ a donation platform.  Users pay for licenses through License Zero because they need them, just like they pay for Amazon Web Services, Microsoft Office, or the toner in the printer.  If software helps do a job, the cost of a license for it should be expensable.  When tax time comes, it might also be deductible.  After all, it's not a gift, a favor, an act of charity, or a pat on the head.  It's just business.

<h2 id="contents">Contents</h2>

This guide begins with a [step-by-step guide to offering licenses through licensezero.com](#step-by-step).

From there, it [takes a deeper dive into the business model](#public-private).  The implementation details take the form of three kinds of forms: [License Zero's free license choices, Parity and Prosperity](#public-licenses), the [private licenses](#private-licnsees) that customers buy, and [waivers](#waivers), which work like free private licenses.

The next section gives [an overview of licensezero.com](#licensezero.com), followed by [an introduction to Artless Devices, the company that runs License Zero](#artless-devices).

The final section [addresses frequently asked questions about how to use or accept code from others](#contributions) in projects being sold through License Zero.

<h2 id="step-by-step">Step by Step</h2>

Start selling through licensezero.com in ten easy steps:

1. Download the command-line interface by running this script in a terminal:

   ```bash
   curl -sL https://licensezero.com/install.sh | sh
   ```

   The script will install a single `licensezero` executable on your search path.

2. Give the command-line interface some information about yourself:

   ```bash
   licensezero identify \
   --name "Jane Developer" \
   --jurisdiction "US-CA" \
   --email "jane@example.com"
   ```

   The jurisdiction argument is an [ISO 3166-2](https://en.wikipedia.org/wiki/ISO_3166-2) standard code for where you live.  See [jurisdictions.licensezero.com](https://jurisdictions.licensezero.com) for a list of all supported countries and subdivisions.

3. Use the command-line interface to register with License Zero:

   ```bash
   licensezero register
   ```

4. Follow the link sent by e-mail to connect your [Stripe](https://stripe.com) account to License Zero. If you don't have a Stripe account yet, follow the instructions to create one.

5. Save the licensor ID and access token licensezero.com gives you:

   ```bash
   licensezero token --licensor bdf5dbb7-5823-41bb-a7a8-07cb5c9739ea
   Token: *************
   ```

   Enter your secret access token at the prompt.

6. Change the license for your project to Parity 7.0.0, the free for open source license, or Prosperity 3.0.0, the noncommercial license.  You can download a plain-text `LICENSE.md` copy of <a href="https://paritylicense.com/7.0.0.md" download="LICENSE.md">Parity 7.0.0</a> or <a href="https://prosperitylicense.com/3.0.0.md" download="LICENSE.md">Prosperity 3.0.0</a> and replace the variables at the top. The identifiers for `package.json` or other package metadata files are `Parity-7.0.0` and `Prosperity-3.0.0`.

7. Offer licenses for your contributions to the project for sale:

   ```bash
   licensezero offer \
   --price 1000 \
   --repository "https://github.com/licensezero/example" \
   --description "demo project for License Zero"
   ```

   Specify your price in United States cents.  `100` is $1.00.  `1000` is $10.00.

8. Add the offer link that licensezero.com provides for you to your project's documentation.  If your packaging system supports funding messages, as does npm, consider [adding your offer URL there, as well](https://blog.licensezero.com/2020/05/09/npm-metadata.html).

9. Tell the world about your project!  Nobody buys licenses for projects they've never heard of.

10. [E-mail Kyle](mailto:kyle@artlessdevices.com), who'll get you plugged into the License Zero user group.  We will help you tell the world.

<h2 id="public-private">Public-Private Licensing</h2>

People tend to skip over code listings.  Don't skip this one!

```python
def licensing(user, contribution):
  # See "Public Licenses" below.
  if user.meets_conditions_of(contribution.public_license):
    contribution.public_license.permit(user)
  else:
    # See "Private Licenses" below.
    private_license = user.private_license_for(contribution)
    if (
      private_license is not None and
      user.meets_conditions_of(private_license)
    ):
      private_license.permit(user)
    # See "Waivers" below.
    else:
      waiver = user.waiver_for(contribution)
      if (
        waiver is not None and
        not waiver.expired
      ):
        waiver.permit(user)
      # See "licensezero.com" below.
      else:
        license_zero.buy_private_license(user, contribution)
```

As an independent software developer, you control who can use your software and under what terms.  License Zero's licenses, [Parity](https://paritylicense.com/) and [Prosperity](https://prosperitylicense.com/), give everyone broad permission to use and build with your software.  However, each license comes with a catch.  Parity requires users to share work they build with your software back as open source.  Prosperity requires users to limit commercial use of your software to a limited free-trial period.

[licensezero.com](https://licensezero.com) can help you sell licenses that allow what Parity and Prosperity don't: use in closed projects and unlimited commercial use.  [Stripe](https://stripe.com) processes the payments directly to an account in your name.  licensezero.com handles taking orders, formatting licenses, and sending receipts.

This [public-private licensing model](https://indieopensource.com/public-private), also know as "dual licensing" or "selling exceptions", is not new.  In fact, it's one of the oldest business models for open source software.  [L. Peter Deutsch](https://en.wikipedia.org/wiki/L._Peter_Deutsch) and [MySQL](https://www.mysql.com/about/legal/licensing/oem/) pioneered it decades ago, and important projects like [Qt](https://www1.qt.io/licensing/) and [MongoDB](https://www.mongodb.com/community/licensing) continue it today.  License Zero evolves the public-private licensing model by making it work for more kinds of software and by making it practical for independent developers who can't or don't want to set up companies, hire sales teams, and write custom legal terms.

<h2 id="public-licenses">Public Licenses</h2>

License Zero starts where you exercise your power as the owner of intellectual property in your work: in your project's `LICENSE` file.  Since license terms in `LICENSE` files apply to everyone, we call them "public licenses".  Later on, we'll distinguish them from the "private licenses" that you sell to individuals.

You might currently use [The MIT License](https://spdx.org/licenses/MIT), [a BSD license](https://spdx.org/licenses/BSD-2-Clause), or a similar open source license there now.  License Zero offers you two alternatives:

1.  <a id="parity"></a>[The Parity Public License](https://licensezero.com/licenses/parity) works a bit like the Creative Commons Share Alike(https://creativecommons.org/licenses/by-sa/4.0/) or the [AGPL](https://www.gnu.org/licenses/agpl-3.0.html), but requires users to release more of their own code, in more situations.  Parity requires users who change, build on, or use your work to create software to release that software as open source, too.

2.  <a id="prosperity"></a>[The Prosperity Public License](https://licensezero.com/licenses/prosperity) works a bit like a [Creative Commons NonCommercial license](https://creativecommons.org/licenses/by-nc/4.0/), but for software.  Prosperity gives everyone broad permission to use your software, but limits commercial use to a short trial period of thirty days.  When a commercial user's trial runs out, they need to buy a private license or stop using your software.

Both options are short and readable.  You should [read](https://paritylicense.com/versions/7.0.0) [them](https://prosperitylicense.com/versions/3.0.0).  Both licenses have improved massively with developer feedback.

<h3 id="which-public-license">Which public license should you use?</h3>

Most developers will ask themselves two simple questions:

First: Will people use your software to build other software?  If your software is a library, framework, developer tool, or deployment tool, they likely will.  Continue to the next question.  If your software is a complete application or plugin, and not a software development or deployment tool, they likely won't.  Choose [Prosperity](#prosperity).

Second: Do you want to let people user your software in business for free, so long as they release software they build with as open source?  If you do, choose [Prosperity](#prosperity).  If you don't, choose [Parity](#parity).

The logic behind these questions is simple:  If you give away all the permission people need for the primary use case of your software, you won't have anything left to sell.  Very few people will need any additional license, and fewer still will buy one.

<h3 id="license-politics">License Politics</h3>

The differences between Parity and Prosperity reflect some political differences that you might want to be aware of.

[Prosperity](#prosperity) is not an "open source" or "free software" license as most understand those terms.  Source code for [Prosperity](#prosperity) software can still be published and developed online, using many popular services like [GitHub](https://github.com) and [npm](https://www.npmjs.com).  But many developers will not accept it as part of their movements, and perhaps criticize you for referring to it as "open source" or "free software".

[Parity](#parity), on the other hand, was written specifically to offer License Zero users an open source license option.

An early version of Parity was proposed to the [Open Source Initiative's license-review mailing list](http://lists.opensource.org/pipermail/license-review_lists.opensource.org/) for approval in September of 2017.  The idea was to discuss the license in one place, for the benefit of all users, rather than having the same conversation a bunch of times all over GitHub and other social media.

Alas, the debate at OSI dragged out, flamed over, and eventually ground to a halt.  Many of the causes were procedural.  Neither the standards nor the process for approval were clear going in, and they did not become clear before going out.  The public documentation for the process at the time, written by a prior OSI board member, better reflected a plan of overdue reform than reality.

In amongst the meta diversions, personal insults, appeals to authority, and attempts to have the submitter kicked off the list via back channels, substantive criticism came largely from two angles:

First, many participants in discussion loathed the dual licensing business model, understood that the license was written to enable it, and condemned the model by way of the license.

Dual licensing and new, stronger copyleft licenses for dual licensing are nothing new.  Attacking them as "not open source" is.

Numerous OSI-approved licenses have been used for dual licensing in the past, from the popular [GNU General Public License, Version 2](https://opensource.org/licenses/GPL-2.0) through to the [Open Software License](https://opensource.org/licenses/OSL-3.0) and [Affero GPL](https://opensource.org/licenses/AGPL-3.0).  OSI approved several licenses written specifically for dual licensing over its history, such as [Sleepycat](https://opensource.org/licenses/Sleepycat), [Q Public License](https://opensource.org/licenses/QPL-1.0), and Reciprocal Public License versions [1.1](https://opensource.org/licenses/RPL-1.1) and [1.5](https://opensource.org/licenses/RPL-1.5).  When these licenses came up, some insisted that OSI made mistakes---repeatedly---and should retract approvals.  When it came to which licenses, exactly, should be retroactively booted, opinions varied widely.

The Open Source Initiative did not take any decision on the license that became Parity.  They did not approve it and they did not reject it.  It was unclear how to get a definitive decision either way.

What we learned, through the process, is that we don't care.  The Open Source Initiative does not own the phrase "open source" as its exclusive intellectual property.  The bedrock of its claims of authority over use of the term---a rigorous, technical definition, a reflection of broad-based consensus---don't hold up.  Which is why it feels a need to [issue press releases](https://opensource.org/OSD_Affirmation) and call in favors.  It's politics, not principle, though it clothes itself in principle.

As for "free software", [Parity](#parity) is probably not a "free software" license [as defined by the Free Software Foundation](https://www.gnu.org/philosophy/free-sw.html).

FSF's definition of free software requires granting freedoms to run, copy, distribute, study, change and improve software.  It also recognizes that some conditions on those freedoms can enhance "software freedom" overall by ensuring that others receive source code and freedom to work with it.  This is exactly the approach [Parity](#parity) takes.

However, FSF's definition of free software admits only conditions on the freedom to share modified versions with others, along the lines of the GPL licenses that FSF has published, and not conditions on other freedoms.  That partially explains why the Open Source Initiative [approved RPL&#x2011;1.5](https://opensource.org/licenses/RPL-1.5), a thematic predecessor of [Parity](#parity), while FSF [considers RPL non-free](https://www.gnu.org/licenses/license-list.en.html#RPL).  It does not explain why the FSF's own Affero GPL license, which requires sharing alike when you _run_ a modified copy of a web service, gets a pass.

In the end, your software is yours to license and market as you choose.  There are no United States registered trademarks on "open source" or "free software" to stop you using them for your work.  Politics and power plays around those terms may or may not matter to you, and they may or may not matter to your users.

<h2 id="private-licenses">Private Licenses</h2>

Users who can't meet the conditions of the public `LICENSE` terms can buy a private license that allows them to use the work without meeting those conditions.  License Zero publishes a [form private license](https://licensezero.com/licenses/private), and sells private licenses to users on developers' behalf.

Each private license grants the buyer broad permission under copyright and patent law to use contributions to an open software project, in language a bit more like what a company legal department would expect.  Otherwise, the legal effect is much like that of a permissive public license, like MIT or BSD, except the private license applies only to the person who bought it, from the date they bought it.

<h3 id="private-sublicensing">Private Sublicensing</h3>

Private licenses give the buyer limited ability to pass their licenses on, or sublicense, others.  Generally speaking, buyers can pass their licenses on to others if they build software with significant additional functionality over and above that of the License Zero code they use.  They can pass on only the right to use the License Zero as part of the new program they've created, and to maintain it.  They _can't_ pass on their license to make changes or build other programs with the software.  In other words, buyers can sublicense the "user" parts of their private licenses, but not the "developer" parts of their private licenses.  Other developers who want to develop new programs, commercially or as closed source, need to buy their own private licenses.

<h3 id="private-license-scope">Private License Scope</h3>

Private licenses last forever, and cover the set of contributions to an open software project that a developer tags with the same [identifier](#identifiers) listed in the private license.  To use an open software project without following the rules of its public licenses, users need other licenses, like private licenses from licensezero.com, that cover every contribution to the project.

Once a developer publishes contributions to a project tagged with a particular identifier, those contributions become forever linked to that identifier.  Developers can't take those contributions back, so that private licenses sold for for that identifier no longer cover them.  That means users can buy the private licenses required for a particular version of a project, and rest assured that they will always have the rights they need for that version.

Apart from this rule against taking contributions back, developers retain total control over what work is covered by a particular identifier.  If a developer embarks on a rewrite, or adds significant new functionality in a major release, they can create a new identifier for that new work, and charge for it separately.  If the new work builds on the old work, users will need private licenses for both identifiers to use the combined project.

In general, there is only one situation where License Zero ever signs any agreement that requires a developer to do work in the future: When a customer sponsors [relicensing](#relicensing) of a set of contributions, the developer must implement the change, according to instructions in the [relicense agreement](#relicense-agreement). Otherwise, License Zero terms only cover work that has already been done. Developers can _choose_ to make additional contributions tagged with old identifiers.  But they can always choose to use a new identifier instead.

<h3 id="not-subscriptions">Not Subscriptions</h3>

Many companies sell proprietary software on subscription. Customers pay a license fee, usually monthly or annually, as long as they use the software.  Subscriptions create recurring revenue for sellers.  Customers continue to pay, month after month, year after year, even if the seller doesn't release any changes to the software.

License Zero does not support subscriptions. Customers pay for private licenses just once, and those licenses last forever.  That design decisions reflects the complexity of subscription licensing, on the one hand, and License Zero's overarching goal of zero friction, on the other.

Subscription license sellers have to charge their customers repeatedly.  Each payment can go wrong.  Payment methods expire.  Delays and errors abound.  Customers go out of business, or decide not to renew.  To cope, sellers pay payment processing and invoice companies, hire billing managers, and even sell debts to collection agencies.

From the customer point of view, sellers go out of business, retire products and services, or let contracts expire to renegotiate price.  To avoid getting stranded, customers demand [source code escrow](https://en.wikipedia.org/wiki/Source_code_escrow), transition services, and other protections against getting stuck without critical software. They push for long price commitments, or rules limiting how much prices can go up each year.

All of that complicates subscription license agreements.  But even the best subscription license agreement eventually ends.  When a subscription ends, for whatever reason, the customer's license for the software ends with it.  Looking at an old proprietary software license, it's rarely clear if the license is still good.   Did one side or the other stop it from renewing?  Did the payment for this year's renewal actually go through?

That uncertainty makes anything like a single form for private license, or [a single command to find what licenses are missing](#as-a-user), impossible.  One-time payments and forever licenses are simpler, both at the time of sale and over the long term.

That doesn't mean developers can't use License Zero to get paid for work over time.  As [mentioned above](#private-license-scope), developers have complete control over whether to make new contributions under an existing licensing identifier, or create a new one.  Developers can create new identifiers for each new major release of a project, or even for each new month.  It's up to developers to communicate those choices to users, if they like, so users know what to expect.  As a baseline, License Zero's licenses and terms only grant licenses for the software developers have already made, in the past.  But licenses for past work don't expire in the future. 

<h2 id="waivers">Waivers</h2>

Waivers work a bit like freebie private licenses.  Developers can use the [command line interface](#command-line-interface) to generate signed [waivers](https://licensezero.com/licenses/waiver), for specific people, that let them out of `LICENSE` conditions limiting commercial use or require open source release.  Developers can generate waivers that last only a set number of days, or that last forever.  The [command line interface](#command-line-interface) treats waivers just like private licenses for purposes of figuring out which private licenses a user is missing for a project.

You might like to issue waivers to reward other contributors to your project who make their work available under a permissive license, for [parallel licensing](#parallel-licensing), extend the free trial period for projects under [Prosperity](#prosperity), or to resolve a question about whether a particular use will trigger the commercial-use time limit.  It's entirely up to you.

<h2 id="licensezero.com">licensezero.com</h2>

licensezero.com is a website and API for selling [private licenses](#private-licenses), closing [relicense deals](#relicensing), and generating [waivers](#waivers).

You can think of licensezero.com as a kind of Internet vending machine.  As a contributor, you can make a deal with the operator of the vending machine to stock it with private licenses and relicense deals for sale.  The vending machine then handles taking payment and spitting out licenses on your behalf.

You could also think of licensezero.com as a kind of e-commerce platform service-izing the back-office operations of a [public-private licensing business](https://indieopensource.com/public-private): negotiation, communication, payment processing, records management.  Rather than start a company and hire people to handle those tasks, or take time away from development to do them yourself, you can use licensezero.com to run your licensing business 24/7.  It works just a well for expensive licenses priced in the thousands of dollars and relatively cheap licenses costing just a few bucks.

<h3 id="stripe-connect">Stripe Connect</h3>

You can create an account to sell private licenses through License Zero by linking a standard [Stripe](https://stripe.com) payment processing account, via [Stripe Connect](https://stripe.com/connect).  Stripe Connect enables licensezero.com to connect its Stripe account to yours, then generate access keys to initiate payment processing requests directly on your account.  Stripe assesses its fee, and any commission for licensezero.com, on the transaction.

<h3 id="identifiers">Identifiers</h3>

licensezero.com generates unique identifiers for licensors and their licensing offers.  The identifiers are version 4 [UUIDs](https://en.wikipedia.org/wiki/Universally_unique_identifier) like:

    daf5a8b1-23e0-4a9f-a6c1-69c40c71816b

Your licensor ID is your identify on licensezero.com.  If you name, e-mail address, or other personal details change, your licensor ID will remain the same.

Each time you offer licenses through licensezero.com, the site will generate an offer ID for you.  Offers are a bit more immutable.  Subject to some exceptions, you can change business details like the price of licenses at any time.  But if you need to change some detail about _what_ you're offering, like its website or description, you will need to retract your old offer and make a new one.

<h3 id="cryptography">Cryptography</h3>

License Zero signs important records like licenses and waivers with a [NaCl](https://nacl.cr.yp.to/)-style [Ed25519](https://ed25519.cr.yp.to/software.html) cryptographic signing keypair.  Customers can check these signatures against licensezero.com's public key. licensezero.com also records the date and cryptographic hash of every record that it signs, along with the signature.

<h3 id="offer-pages">Offer Pages</h3>

licensezero.com serves a page with information and purchase forms for each identifier.  For example:

<https://licensezero.com/offers/daf5a8b1-23e0-4a9f-a6c1-69c40c71816b>

The URL pattern is:

```text
https://licensezero.com/offers/{UUID}
```

<h3 id="pricing-graphics">Pricing Graphics</h3>

licensezero.com serves SVG graphics with private-license pricing information that you can include in your projects' `README` files or other documentation.  For example:

<figure><img alt="a pricing graphic" src="https://licensezero.com/offers/daf5a8b1-23e0-4a9f-a6c1-69c40c71816b/badge.svg"></figure>

The URL pattern is:

```text
https://licensezero.com/offers/{UUID}/badge.svg
```

The Markdown syntax is:

```markdown
![L0](https://licensezero.com/offers/{UUID}/badge.svg)
```

<h2 id="artless-devices">Artless Devices</h2>

Artless Devices LLC is a California limited liability company.  It serves as the legal counterpart to licensezero.com.  As a developer offering private licenses for sale through licensezero.com, you will have three legal relationships with Artless Devices:

<h3 id="service-provider">Service Provider</h3>

To use licensezero.com and its API, you must agree to [terms of service](https://licensezero.com/terms/service) with Artless Devices.  The terms were written to be read, and you should read them.  They set important rules about responsibility and liability, and make very explicit that Artless Devices isn't going to provide, or be responsible for, any legal advice about whether License Zero is right for you or your work.

<h3 id="licensing-agent">Licensing Agent</h3>

To offer private licenses for sale through licensezero.com, you agree to the [agency terms](https://licensezero.com/terms/agency) with Artless Devices.  You should definitely read that agreement, and again, it was written to be read, not to glaze your eyes over.  But there are a few especially important aspects, from Artless Devices' point of view.

First and foremost, you appoint Artless Devices as your agent to sign license agreements, waivers, and relicense agreements on your behalf.  That means that Artless Devices can do the deals you authorize through the API, via licensezero.com, with the same effect as if you'd signed them yourself.

Second, Artless Devices earns commission on private license sales.  The amount is set out in the agency terms when you offer your work for private licensing.

Third, you guarantee that you have the rights to offer the software you offer to license through License Zero, and to keep your projects' metadata in line with what the [command line interface](#command-line-interface) generates.  The guarantee helps protect Artless Devices from those trying to take license fees for others' work.  Your promise about metadata helps ensure that the [command line interface](#command-line-interface) works as intended for users buying licenses.

Fourth, the relationship isn't exclusive, and with the exception of work [for which you lock availability](#locks), either side can end it at any time.  You can sell private licenses through other services, or on your own.

Finally, neither the terms of service nor the agency terms change ownership of any intellectual property in your work.  You own your rights, and you keep them.  Artless Devices doesn't receive a license from you.  Rather, you license users and agree to relicense your work directly.  Artless Devices merely acts as your agent, signing on your behalf, as you've directed via the API.

<h3 id="toolmaker">Toolmaker</h3>

Artless Devices owns and licenses the intellectual property in the [command line interface](#command-line-interface) that you will use to register and offer licenses for sale, as well as [forms and other software tools published online](https://github.com/licensezero).

<h2 id="contributions">Contributions</h2>

As a independent software maintainer, you can license your work under both a [public `LICENSE` terms](#public-license) and [private licenses](#private-licenses) at the same time because you own the intellectual property in your work that others needs licenses for.  In other words, you can license your work in two ways at once because you own it.

When others contribute to your work, they will own the intellectual property in their contributions, not you.  As a result, users of your combined work will need licenses from you and from other contributors.  There are two straightforward ways to achieve that.

<h3 id="parallel-licensing">Parallel Licensing</h3>

You can choose to take contributions to your project only from those who license their contributions under permissive open source terms.  For example, you might license your contributions to a project under [Parity terms](#parity), but ask contributors to license their work under [Blue Oak](#permissive-license), and append the text of that license to your project's `LICENSE` file with a note that others' contributions come under that license.

Users of the combined project would then receive a license from you on [Parity terms](#parity), for your contributions, and licenses from other contributors on [permissive terms](#permissive-license), for their contributions.  Would-be users who won't abide by the open source release conditions of your license can still buy a private license from you, for your contributions.  The private license for your work, plus the permissive license for others' contributions, cover all contributions.

In that kind of situation, you can sell private licenses for your contributions to the project, but others cannot.  Perhaps that feels completely fair.  If it doesn't, you may like to offer special credit, payment, or a free [waiver](#waiver) to contributors, to convince them to license their contributions under permissive terms.

<h3 id="stacked-licensing">Stacked Licensing</h3>

License Zero also supports projects that require multiple private licenses, for contributions from different developers.  If you publish contributions under [The Parity Public License](#parity), and another developer forks, licensing their own work under [The Parity Public License](#parity), too, they can append `licensezero.json` metadata for a separate License Zero identifier.  Users who run the [command line interface](#command-line-interface) will see that they need a private license from each of you to use the project as a whole.  The same could happen with two contributors using [The Prosperity Public License](#prosperity), or contributors using a mix of `LICENSE` terms.

Note that as a contributor, you control pricing only for your own contributions, not anyone else's contributions, even if their work builds on yours.  Contributors building on top of work you license under [The Prosperity Public License](#prosperity) will need to purchase private licenses from you to use and build on your work for the purpose of making money through licensezero.com, but otherwise, licensezero.com doesn't say anything about any relationship between you.

<h3 id="license-graphs">License Graphs</h3>

Packages, tools, and projects depend on other packages, tools, and projects in turn.  These relationships create webs of dependencies, or dependency graphs, within software projects.

Users need licenses for all intellectual property within their software projects, including its dependencies.  And they must follow the rules of each of those licenses.  That means each project tree has not just a dependency graph, but a _license graph_, as well.  The License Zero command line interface [traverses the license graph automatically](#as-a-user), seeking out License Zero packages.

Consider this dependency graph:

<figure id="figure-1">
  <img src=./figure-1.svg alt="Figure 1">
  <figcaption>Figure 1: A Dependency Graph</figcaption>
</figure>

Package A depends on Package B and Package C.  Package C depends on Package D in turn.

When all contributions to each package in the graph are licensed under the same terms, users must follow the rules of that license for all code in the graph:

<figure id="figure-2">
  <img src=./figure-2.svg alt="Figure 2">
  <figcaption>Figure 2: A Dependency Graph Under One License</figcaption>
</figure>

In this case, all the packages in the dependency graph are licensed under [Parity](#parity) terms.  Parity allows this, as long as source code for all the packages gets released, and each package preserves the license terms and notices of its dependencies.

However, the licenses for packages in a dependency graph need not be the same:

<figure id="figure-3">
  <img src=./figure-3.svg alt="Figure 3">
  <figcaption>Figure 3: A Dependency Graph Under Different Licenses</figcaption>
</figure>

A user of package A needs to follow the rules of _both_ [Parity](#parity) and [Prosperity](#prosperity), in order to use package A.  That means _both_ limiting commercial use to 32 days _and_ releasing source code for software built with package D, including for software built with package C or Package A.

Note that the authors of package A and package C are free to license work on their own packages under MIT and Blue Oak terms, respectively.  The Parity license of package D requires release of source code and licensing on terms at least as permissive as Parity.  Both MIT and Blue Oak are _more_ permissive than Parity, with _fewer_ rules about releasing source code.

The author of package A must mind the license rules for the Prosperity license for package B, too.  If the author of package A wrote that package primarily as a hobby, or as academic research, they're free to continue using package B indefinitely.  If the author of package A instead wrote package A primarily to make money, they need a private license for contributions to package B, so as not to exceed the 32-day trial period.

The bad news is that license graphs can be even more complex, where packages also used [stacked licensing](#stacked-licensing):

<figure id="figure-4">
  <img src=./figure-4.svg alt="Figure 4">
  <figcaption>Figure 4: A Dependency Graph with Packages Stacking Licenses</figcaption>
</figure>

This kind of complexity shows up even in existing open software projects that don't use any License Zero licenses, with mixes of GPL, BSD, MIT, LGPL, and other licenses.

The good news is that tools like the [license zero command line interface](#command-line-interface) can traverse even complex license graphs automatically, compile a list of every [identifier](#identifiers) mentioned in metadata, and compare those results against the licenses and waivers that the user already has.  The License Zero command line interface merely evolves, and specializes, [existing tools for analyzing open source license graphs](https://www.npmjs.com/package/licensee).
